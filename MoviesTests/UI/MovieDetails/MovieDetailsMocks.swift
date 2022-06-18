//
//  MovieDetailsMocks.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import Foundation
@testable import Movies

class MovieDetailsViewControllerSpy: MovieDetailsViewContract {
    
    var displayMovieDetailsCalled: Bool = false
    var displayMovieDetailsArg: MovieDetailsProps?
    
    func displayMovieDetails(_ movie: MovieDetailsProps) {
        displayMovieDetailsCalled = true
        displayMovieDetailsArg = movie
    }
    
}
