//
//  MovieDetailsViewControllerTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 5.02.2022.
//

import XCTest
@testable import MoviesDemo

class MovieDetailsViewControllerTests: XCTestCase {

    var sut: MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailViewController(movie: MockGenerator.createMovie())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldBindModelWhenViewDidLoadCalled() {
        // When
        _ = sut.view
        
        // Then
        XCTAssertEqual(sut.detailView.movieNameLabel.text, "Test")
        XCTAssertEqual(sut.detailView.descriptionLabel.text, "Description: Test")
        XCTAssertEqual(sut.detailView.ratingLabel.text!, "Rating: 1.0")
        XCTAssertEqual(sut.detailView.languageLabel.text!, "Language: " + OriginalLanguage.en.rawValue)
    }

}
