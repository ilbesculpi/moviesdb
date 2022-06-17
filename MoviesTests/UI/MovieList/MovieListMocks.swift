//
//  MovieListMocks.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import Foundation
@testable import Movies

class MovieListViewModelSpy: MovieListViewModelContract {
    
    var fetchMoviesCalled: Bool = false
    
    func fetchMovies() {
        fetchMoviesCalled = true
    }
    
}
