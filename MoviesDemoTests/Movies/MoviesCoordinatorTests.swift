//
//  MoviesCoordinatorTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 4.02.2022.
//

import XCTest
@testable import MoviesDemo

class MoviesCoordinatorTests: XCTestCase {

    var sut: MoviesCoordinator!
    
    override func setUp() {
        super.setUp()
        let window = UIWindow(frame: .zero)
        let navigationController = MockNavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        sut = MoviesCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldStartMoviesViewController() {
        // When
        sut.start()
        
        // Then
        XCTAssertTrue(sut.navigationController.children.first is MoviesViewController)
    }
    
    func test_ShouldOpenMovieDetailsWhenDelegateInformed() {
        // When
        sut.start()
        sut.moviesViewControllerDidTapNext(getMoviesViewController(), for: MockGenerator.createMovie())
        
        // Then
        XCTAssertTrue(sut.navigationController.children.last is MovieDetailViewController)
    }

    
    func getMoviesViewController() -> MoviesViewController {
        
        let businessController = MoviesBusinessController(networkManager: MockNetworkManager())
        let tableDataSource = MoviesTableViewDataSource()
        let collectionDataSource = MoviesCollectionViewDataSource()
        return MoviesViewController(businessController: businessController,
                                    tableDataSource: tableDataSource,
                                    collectionDataSource: collectionDataSource)
    }
}
