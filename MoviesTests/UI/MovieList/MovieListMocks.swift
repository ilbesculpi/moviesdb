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
    
    func displayMovies(_ movies: [MovieListItemProps], fetchMore: Bool) {
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
    
    
    // MARK: - fetchNextItems()
    var fetchNextItemsCalled: Bool = false
    func fetchNextItems() {
        fetchMoviesCalled = true
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
    var fetchMoviesArg2: Int?
    var publisher = PassthroughSubject<FetchMoviesResponse, Error>()
    var subject: AnyPublisher<FetchMoviesResponse, Error>!
    
    func fetchMovies(_ sort: MovieListType, page: Int) -> AnyPublisher<FetchMoviesResponse, Error> {
        fetchMoviesCalled = true
        fetchMoviesArg = sort
        fetchMoviesArg2 = page
        subject = publisher.eraseToAnyPublisher()
        return subject
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
