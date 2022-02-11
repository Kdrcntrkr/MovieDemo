//
//  MoviesCollectionViewDataSourceTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 5.02.2022.
//

import XCTest
@testable import MoviesDemo

class MoviesCollectionViewDataSourceTests: XCTestCase {

    var sut: MoviesCollectionViewDataSource!
    var collectionView: UICollectionView!
    var model: [Movie]!
    
    override func setUp() {
        super.setUp()
        model = [MockGenerator.createMovie()]
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        sut = MoviesCollectionViewDataSource()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldRegisterCell() {
        // Given
        sut.movies = model
        sut.registerCells(to: collectionView)
        let indexPath = IndexPath(item: 0, section: 0)

        // When
        let cell = sut.collectionView(collectionView, cellForItemAt: indexPath)

        //Then
        XCTAssertTrue(cell is MovieCollectionViewCell)
    }
    
    func test_ShouldConfigureCell() {
        // Given
        sut.movies = model
        sut.registerCells(to: collectionView)

        // When
        let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? MovieCollectionViewCell
        
        //Then
        XCTAssertEqual(cell?.titleLabel.text, model.first?.title)
    }

}
