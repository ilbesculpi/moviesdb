//
//  MovieListMocks.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import Foundation
import Combine
@testable import Movies

class MovieListViewSpy: MovieListViewContract {
    
    var displayMoviesCalled: Bool = false
    var displayMoviesArg: [MovieListItemProps]?
    
    func displayMovies(_ movies: [MovieListItemProps]) {
        displayMoviesCalled = true
        displayMoviesArg = movies
    }
    
}

class MovieListViewModelSpy: MovieListViewModelContract {
    
    var view: MovieListViewContract!
    var fetchMoviesCalled: Bool = false
    var fetchMoviesArg: MovieListType?
    
    func fetchMovies(sorted: MovieListType) {
        fetchMoviesCalled = true
        fetchMoviesArg = sorted
    }
    
}

class MovieServiceSpy: MovieService {
    
    var fetchMoviesCalled: Bool = false
    var fetchMoviesArg: MovieListType?
    var publisher = PassthroughSubject<[Movie], Error>()
    
    func fetchMovies(_ sort: MovieListType) -> AnyPublisher<[Movie], Error> {
        fetchMoviesCalled = true
        fetchMoviesArg = sort
        return publisher.eraseToAnyPublisher()
    }
    
    func emitMovies(_ values: [Movie]) {
        publisher.send(values)
    }
    
    
}
