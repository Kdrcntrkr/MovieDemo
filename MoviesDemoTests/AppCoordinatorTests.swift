//
//  AppCoordinatorTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 4.02.2022.
//

import XCTest
@testable import MoviesDemo

class AppCoordinatorTest: XCTestCase {

    var sut: AppCoordinator!

    override func setUp() {
        super.setUp()
        sut = AppCoordinator(navigationController: UINavigationController())
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
}

