//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import Foundation
import Combine

class MovieListViewModel: MovieListViewModelContract {
    
    var repository: MovieService
    weak var view: MovieListViewContract!
    var cancellables = Set<AnyCancellable>()
    var sortBy: MovieListType = .popular
    var movies: [Movie] = []
    var selectedMovie: Movie?
    
    init(repository: MovieService) {
        self.repository = repository
    }
    
    func toggleFilter(sorted: MovieListType) {
        sortBy = sorted
        fetchMovies(sorted: sortBy)
    }
    
    func fetchMovies(sorted: MovieListType) {
        
        switch sorted {
        case .popular:
            self.view.displayTitle("Popular Movies")
        case .topRated:
            self.view.displayTitle("Top Rated Movies")
        }
        
        repository.fetchMovies(sorted)
            .receive(on: DispatchQueue.main)
            .map(\.results)
            .map({ [weak self] movies -> [MovieListItemProps] in
                self?.movies = movies
                return movies.map({
                    var item = MovieListItemProps()
                    item.title = $0.title
                    item.overview = $0.overview
                    if let releaseDate = $0.releaseDateObj {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MMM dd, yyyy"
                        item.date = formatter.string(from: releaseDate)
                    }
                    item.imageUrl = URL(string: $0.posterUrl)
                    return item
                })
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movies: " + error.localizedDescription)
                    // TODO: handle api error
                case .finished:
                    print("fetch complete")
                }
            }, receiveValue: { [weak self] movies in
                print("Display \(movies.count) movies")
                self?.view.displayMovies(movies)
            })
            .store(in: &cancellables)
    }
    
    func selectMovie(at index: Int) {
        guard movies.indices.contains(index) else {
            print("Invalid index")
            return
        }
        selectedMovie = movies[index]
    }
    
}
