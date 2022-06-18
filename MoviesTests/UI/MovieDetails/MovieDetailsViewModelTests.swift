//
//  MovieDetailsViewModelTests.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import XCTest
@testable import Movies

class MovieDetailsViewModelTests: XCTestCase {

    var viewModel: MovieDetailsViewModel!
    var viewControllerSpy: MovieDetailsViewControllerSpy!
    
    override func setUp() {
        viewModel = MovieDetailsViewModel()
        viewControllerSpy = MovieDetailsViewControllerSpy()
        viewModel.view = viewControllerSpy
    }
    
    override func tearDown() {
        viewModel = nil
        viewControllerSpy = nil
    }
    
    func testViewModelShouldInstructViewToDisplayMovieProps() {
        
        // When: Given a Movie
        let movie = Movie(id: 1, title: "Titanic")
        viewModel.setMovie(movie)
        
        // Then: Call viewModel.fetchMovie()
        viewModel.fetchMovie()
        
        // Expect: viewModel should instruct view to display props
        XCTAssertTrue(viewControllerSpy.displayMovieDetailsCalled)
        XCTAssertEqual("Titanic", viewControllerSpy.displayMovieDetailsArg?.title)
    }
    
    func testViewModelShouldInstructViewToDisplayMovieTitle() {
        
        // When: Given a Movie
        let movie = Movie(id: 1, title: "Titanic")
        viewModel.setMovie(movie)
        
        // Then: Call viewModel.fetchMovie()
        viewModel.fetchMovie()
        
        // Expect: viewModel should instruct view to display props
        XCTAssertTrue(viewControllerSpy.displayTitleCalled)
        XCTAssertEqual("Titanic", viewControllerSpy.displayTitleArg)
    }

}
