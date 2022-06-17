//
//  MovieListViewControllerTests.swift
//  MoviesTests
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import XCTest
@testable import Movies

class MovieListViewControllerTests: XCTestCase {
    
    var viewController: MovieListViewController!
    var viewModelSpy: MovieListViewModelSpy!
    
    override func setUp() {
        
        // Configure dependencies
        viewModelSpy = MovieListViewModelSpy()
        AppContainer.container.register(MovieListViewModelContract.self) { _ in
            self.viewModelSpy
        }
        
        // Instantiate SUT
        let bundle = Bundle(for: MovieListViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(identifier: "MovieList")
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewModelSpy = nil
        viewController = nil
    }
    
    func testViewsSetup() {
        XCTAssertNotNil(viewController.tableView)
        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertNotNil(viewController.tableView.delegate)
    }
    
    func testViewDependencies() {
        XCTAssertNotNil(viewController.viewModel)
    }
    
    func testViewShouldAskViewModelForMovies() {
        XCTAssertTrue(viewModelSpy.fetchMoviesCalled)
    }

}
