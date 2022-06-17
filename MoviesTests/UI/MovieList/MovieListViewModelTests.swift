//
//  MovieListViewModelTests.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import XCTest
import Combine
@testable import Movies

class MovieListViewModelTests: XCTestCase {
    
    var viewModel: MovieListViewModel!
    var repositorySpy: MovieServiceSpy!
    var viewControllerSpy: MovieListViewSpy!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        
        repositorySpy = MovieServiceSpy()
        viewModel = MovieListViewModel(repository: repositorySpy)
        viewControllerSpy = MovieListViewSpy()
        viewModel.view = viewControllerSpy
        
    }

    override func tearDown() {
        repositorySpy = nil
        viewControllerSpy = nil
        viewModel = nil
    }
    
    func testShouldAskRepositoryForMovies() {
        
        // When: given a list of movies
        let movies = [
            Movie(id: 1, title: "Inception"),
            Movie(id: 2, title: "The Lost City"),
            Movie(id: 3, title: "Titanic")
        ]
        
        // Then: Call viewModel.fetchMovies()
        viewModel.fetchMovies(sorted: .popular)
        
        // Expect: call to repository.fetchMovies()
        let expectation = expectation(description: "fetchMovies")
        
        repositorySpy.publisher
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { value in
                XCTAssertTrue(self.repositorySpy.fetchMoviesCalled)
                XCTAssertEqual(MovieListType.popular, self.repositorySpy.fetchMoviesArg)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        
        repositorySpy.emitMovies(movies)
        wait(for: [expectation], timeout: 3)
            
        
    }

}
