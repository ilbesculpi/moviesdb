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
        
        // Then: Subscribe to publisher
        let expectation = expectation(description: "fetchMovies")
        repositorySpy.publisher
            .sink { value in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then: emit values
        repositorySpy.emitMovies(movies)
        wait(for: [expectation], timeout: 3)
        
        // Expect: viewModel should call repository.fetchMovies()
        XCTAssertTrue(repositorySpy.fetchMoviesCalled)
        XCTAssertEqual(MovieListType.popular, repositorySpy.fetchMoviesArg)
    }
    
    
    func testShouldDisplayTitleOnView() {
        
        // When: given a list of movies
        let movies = [
            Movie(id: 1, title: "Inception"),
            Movie(id: 2, title: "The Lost City"),
            Movie(id: 3, title: "Titanic")
        ]
        
        // Then: Call viewModel.fetchMovies()
        viewModel.fetchMovies(sorted: .popular)
        
        // Expect: should set view title
        repositorySpy.emitMovies(movies)
        XCTAssertTrue(self.viewControllerSpy.displayTitleCalled)
        XCTAssertEqual("Popular Movies", self.viewControllerSpy.displayTitleArg!)
        
        // Then: Call viewModel.fetchMovies()
        viewModel.fetchMovies(sorted: .topRated)
        
        // Expect: should set view title
        repositorySpy.emitMovies(movies)
        XCTAssertTrue(self.viewControllerSpy.displayTitleCalled)
        XCTAssertEqual("Top Rated Movies", self.viewControllerSpy.displayTitleArg!)
    }
    
    func testShouldDisplayMoviesOnView() {
        
        // When: given a list of movies
        let movies = [
            Movie(id: 1, title: "Inception"),
            Movie(id: 2, title: "The Lost City"),
            Movie(id: 3, title: "Titanic")
        ]
        
        // Then: Call viewModel.fetchMovies()
        viewModel.fetchMovies(sorted: .popular)
        
        // Then: Subscribe to publisher
        let expectation = expectation(description: "fetchMovies")
        repositorySpy.publisher
            .delay(for: 0.5, scheduler: RunLoop.main) // give publisher time to emit values
            .sink { value in
                // Expect: value should contain a viewProps for every movie
                XCTAssertTrue(self.viewControllerSpy.displayMoviesCalled)
                guard let items = self.viewControllerSpy.displayMoviesArg else {
                    XCTFail("no displayMoviesArg value")
                    return
                }
                XCTAssertEqual(3, items.count)
                XCTAssertEqual("Inception", items[0].title)
                XCTAssertEqual("The Lost City", items[1].title)
                XCTAssertEqual("Titanic", items[2].title)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        
        // Then: emit values
        repositorySpy.emitMovies(movies)
        wait(for: [expectation], timeout: 3)
    }

}
