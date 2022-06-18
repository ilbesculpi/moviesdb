//
//  MovieDetailsMocks.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import Foundation
@testable import Movies

class MovieDetailsViewControllerSpy: MovieDetailsViewContract {
    
    // MARK: - displayTitle(_)
    var displayTitleCalled: Bool = false
    var displayTitleArg: String?
    func displayTitle(_ title: String) {
        displayTitleCalled = true
        displayTitleArg = title
    }
    
    // MARK: - displayMovieDetails(_)
    var displayMovieDetailsCalled: Bool = false
    var displayMovieDetailsArg: MovieDetailsProps?
    func displayMovieDetails(_ movie: MovieDetailsProps) {
        displayMovieDetailsCalled = true
        displayMovieDetailsArg = movie
    }
    
}

class MovieDetailsViewModelSpy: MovieDetailsViewModelContract {
    
    var view: MovieDetailsViewContract!
    
    
    // MARK: - fetchMovie()
    var fetchMovieCalled: Bool = false
    func fetchMovie() {
        fetchMovieCalled = true
    }
    
    
    // MARK: - setMovie(_)
    var setMovieCalled: Bool = false
    var setMovieArg: Movie?
    func setMovie(_ movie: Movie) {
        setMovieCalled = true
        setMovieArg = movie
    }
    
}
