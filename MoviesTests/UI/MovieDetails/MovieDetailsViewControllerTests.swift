//
//  MovieDetailsViewControllerTests.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import XCTest
@testable import Movies

class MovieDetailsViewControllerTests: XCTestCase {

    var viewController: MovieDetailsViewController!
    var viewModelSpy: MovieDetailsViewModelSpy!
    
    override func setUp() {
        
        // Configure dependencies
        viewModelSpy = MovieDetailsViewModelSpy()
        
        // Instantiate SUT
        let bundle = Bundle(for: MovieListViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(identifier: "MovieDetails")
        viewController.viewModel = viewModelSpy
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewModelSpy = nil
        viewController = nil
    }
    
    func testViewShouldAskViewModelForMovieDetails() {
        XCTAssertTrue(viewModelSpy.fetchMovieCalled)
    }
    
    func testViewShouldUpdateViews() {
        
        // When: Given a movie
        let movie = MovieDetailsProps(
            title: "Titanic",
            overview: "Lorem Ipsum",
            releaseDate: "Jun 1, 2020"
        )
        
        // Then: call viewController.displayMovieDetails()
        viewController.displayMovieDetails(movie)
        
        // Expect: views should contain given data
        XCTAssertEqual("Titanic", viewController.labelTitle.text)
        XCTAssertEqual("Lorem Ipsum", viewController.labelOverview.text)
        XCTAssertEqual("Jun 1, 2020", viewController.labelReleaseDate.text)
    }
    
    func testViewShouldDisplayTitle() {
                
        // Then: call viewController.displayMovieDetails()
        viewController.displayTitle("Titanic")
        
        // Expect: views should contain given data
        XCTAssertEqual("Titanic", viewController.title)
    }

}
