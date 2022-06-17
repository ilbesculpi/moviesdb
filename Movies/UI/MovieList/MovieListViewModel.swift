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
    
    init(repository: MovieService) {
        self.repository = repository
    }
    
    func fetchMovies(sorted: MovieListType) {
        repository.fetchMovies(sorted)
            .map({ movies in
                return movies.map({
                    var item = MovieListItemProps()
                    item.title = $0.title
                    item.imageUrl = $0.posterUrl
                    return item
                })
            })
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { [weak self] values in
                self?.view.displayMovies(values)
            })
            .store(in: &cancellables)
    }
    
}
