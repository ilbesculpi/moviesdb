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
    var response: FetchMoviesResponse!
    
    init(repository: MovieService) {
        self.repository = repository
    }
    
    func toggleFilter(sorted: MovieListType) {
        sortBy = sorted
        movies = []
        response = nil
        fetchMovies(sorted: sortBy)
    }
    
    func fetchMovies(sorted: MovieListType) {
        fetchMovies(sorted: sorted, page: 1)
    }
    
    func fetchMovies(sorted: MovieListType, page: Int = 1) {
        
        switch sorted {
        case .popular:
            self.view.displayTitle("Popular Movies")
            print("Fetch Popular Movies #\(page)")
        case .topRated:
            self.view.displayTitle("Top Rated Movies")
            print("Fetch Top Rated Movies #\(page)")
        }
        
        repository.fetchMovies(sorted, page: page)
            .receive(on: DispatchQueue.main)
            .map({ [weak self] response -> [Movie]  in
                self?.response = response
                return response.results
            })
            .map({ [weak self] movies -> [MovieListItemProps] in
                // append items
                guard let viewModel = self else {
                    return []
                }
                viewModel.movies.append(contentsOf: movies)
                return viewModel.movies.map({
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
                print("Display \(movies.count) movies.")
                if let response = self?.response {
                    let fetchMore = response.total_pages > page
                    self?.view.displayMovies(movies, fetchMore: fetchMore)
                }
            })
            .store(in: &cancellables)
    }
    
    func fetchNextItems() {
        print("Fetch next rows")
        let nextPage = response == nil ? 1 : response.page + 1
        fetchMovies(sorted: self.sortBy, page: nextPage)
    }
    
    func selectMovie(at index: Int) {
        guard movies.indices.contains(index) else {
            print("Invalid index")
            return
        }
        selectedMovie = movies[index]
    }
    
}
