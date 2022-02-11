//
//  MoviesViewControllerTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 4.02.2022.
//

import XCTest
@testable import MoviesDemo

class MoviesViewControllerTests: XCTestCase {

    var sut: MoviesViewController!
    var businessController: MockBusinessController!
    
    override func setUp() {
        super.setUp()
        businessController = MockBusinessController(networkManager: MockNetworkManager())
        sut = MoviesViewController(businessController: businessController,
                                   tableDataSource: MoviesTableViewDataSource(),
                                   collectionDataSource: MoviesCollectionViewDataSource())
    }
    
    override func tearDown() {
        sut = nil
        businessController = nil
        super.tearDown()
    }
    
    func test_ShouldGetDataWhenViewDidLoadCalled() {
        // When
        _ = sut.view
        
        // Then
        XCTAssertTrue(businessController.didCallGetMoviesAndFavorites)
    }
    
    func test_ShouldSelectTableCellWhenFavoritesCellIsSelected() {
        // When
        _ = sut.view
        sut.collectionView(sut.moviesView.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(sut.moviesView.tableView.indexPathForSelectedRow)
    }
    
    func test_ShouldSelectFavoriteCellWhenTableCellIsSelected() {
        // When
        _ = sut.view
        sut.tableView(sut.moviesView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(sut.moviesView.collectionView.indexPathsForSelectedItems?.count, 1)
    }
    
    func test_ShouldDeselectFavoriteCellWhenNotFavoriteTableCellSelected() {
        // When
        _ = sut.view
        sut.tableView(sut.moviesView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(sut.moviesView.collectionView.indexPathsForSelectedItems?.count, 1)
        
        // When
        sut.tableView(sut.moviesView.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))

        // Then
        XCTAssertEqual(sut.moviesView.collectionView.indexPathsForSelectedItems?.count, 0)

    }
    
    func test_ShouldInformDelegateWhenCellIsSelectedAndTappedNextButton() {
        // Given
        let mockDelegate = MockDelegate()
        
        // When
        _ = sut.view
        sut.delegate = mockDelegate
        sut.collectionView(sut.moviesView.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        sut.moviesView.nextButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertTrue(mockDelegate.didTapNextButton)
    }
    
    class MockBusinessController: MoviesBusinessController {
        private(set) var didCallGetMoviesAndFavorites = false
        
        override func fetchMoviesAndFavorites(completion: @escaping (MoviesBusinessController.Model) -> Void) {
            didCallGetMoviesAndFavorites = true
            model = MockGenerator.createMovieBusinessModel()
            completion(model)
        }
    }
    
    class MockDelegate: MoviesViewControllerDelegate {
        private(set) var didTapNextButton = false
        
        func moviesViewControllerDidTapNext(_ moviesViewController: MoviesViewController, for movie: Movie) {
            didTapNextButton = true
        }
    }

}
