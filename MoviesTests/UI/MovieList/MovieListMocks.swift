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
    
    
    // MARK: - displayMovies(_)
    var displayMoviesCalled: Bool = false
    var displayMoviesArg: [MovieListItemProps]?
    
    func displayMovies(_ movies: [MovieListItemProps]) {
        displayMoviesCalled = true
        displayMoviesArg = movies
    }
    
    // MARK: - displayTitle(_)
    var displayTitleCalled: Bool = false
    var displayTitleArg: String?
    
    func displayTitle(_ title: String) {
        displayTitleCalled = true
        displayTitleArg = title
    }
    
}

class MovieListViewModelSpy: MovieListViewModelContract {
    
    var view: MovieListViewContract!
    var selectedMovie: Movie?
    
    // MARK: - fetchMovies(_)
    var fetchMoviesCalled: Bool = false
    var fetchMoviesArg: MovieListType?
    
    func fetchMovies(sorted: MovieListType) {
        fetchMoviesCalled = true
        fetchMoviesArg = sorted
    }
    
    // MARK: - toggleFilter(sorted:)
    var toggleFilterCalled: Bool = false
    var toggleFilterArg: MovieListType?
    
    func toggleFilter(sorted: MovieListType) {
        toggleFilterCalled = true
        toggleFilterArg = sorted
    }
    
    // MARK: - selectMovie(at:)
    var selectMovieCalled: Bool = false
    var selectMovieArg: Int?
    func selectMovie(at index: Int) {
        selectMovieCalled = true
        selectMovieArg = index
    }
    
}

class MovieServiceSpy: MovieService {
    
    var fetchMoviesCalled: Bool = false
    var fetchMoviesArg: MovieListType?
    var publisher = PassthroughSubject<FetchMoviesResponse, Error>()
    
    func fetchMovies(_ sort: MovieListType) -> AnyPublisher<FetchMoviesResponse, Error> {
        fetchMoviesCalled = true
        fetchMoviesArg = sort
        return publisher.eraseToAnyPublisher()
    }
    
    func emitMovies(_ values: [Movie], page: Int = 1, total_pages: Int = 1, total_results: Int = 10) {
        let result = FetchMoviesResponse(
            page: page,
            results: values,
            total_pages: total_pages,
            total_results: total_results
        )
        publisher.send(result)
    }
    
    
}
