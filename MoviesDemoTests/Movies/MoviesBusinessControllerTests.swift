//
//  MoviesBusinessControllerTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 5.02.2022.
//

import XCTest
@testable import MoviesDemo

class MoviesBusinessControllerTests: XCTestCase {

    var sut: MoviesBusinessController!
    var networkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        sut = MoviesBusinessController(networkManager: networkManager)
    }
    
    override func tearDown() {
        networkManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldFetchFavoritesSuccessfully() {
        // Given
        let fetchDataExpectation = expectation(description: "Fetch Data")
        var favsModel: Favorites?
        networkManager.dataType = .favorites
        
        // When
        sut.getFavs { result in
            if case .success(let favs) = result {
                favsModel = favs
            } else {
                XCTAssertTrue(false)
            }
            fetchDataExpectation.fulfill()
        }
        
        // Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertEqual(favsModel?.results.count, 1)
    }
    
    func test_ShouldFetchMovieListSuccessfully() {
        // Given
        let fetchDataExpectation = expectation(description: "Fetch Data")
        var movieList: MovieList?
        networkManager.dataType = .movies
        
        // When
        sut.getMovies { result in
            if case .success(let list) = result {
                movieList = list
            } else {
                XCTAssertTrue(false)
            }
            fetchDataExpectation.fulfill()
        }
        
        // Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertEqual(movieList?.results.count, 6)
    }
    
    func test_ShouldFetchModelSuccessfully() {
        // Given
        let fetchDataExpectation = expectation(description: "Fetch Data")
        var model = MoviesBusinessController.Model(favorites: nil, movieList: nil)
        sut = MockBusinessController(networkManager: networkManager)
        
        // When
        sut.fetchMoviesAndFavorites { result in
            model = result
            fetchDataExpectation.fulfill()
        }
        
        // Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertEqual(model.favoriteList?.count, 1)
        XCTAssertEqual(model.watchedMovies?.count, 3)
    }
    
    func test_ShouldGetSelectedMovieForIndexPath() {
        // Given
        sut.model = MockGenerator.createMovieBusinessModel()
        let indexPath = IndexPath(row: 0, section: 0)
        var movie: Movie?
        
        // When
        movie = sut.getSelectedMovie(from: indexPath)
        
        // Then
        XCTAssertNotNil(movie)
    }
    
    func test_ShouldReturnIndexPathOfFavoriteCellForSelectedTableViewCell() {
        // Given
        sut.model = MockGenerator.createMovieBusinessModel()
        var indexPath: IndexPath?
        
        // When
        indexPath = sut.getIndexPathOfFavoriteCellfForSelectedTableCell(indexPath: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertNotNil(indexPath)
    }
    
    func test_ShouldReturnIndexPathOfTableCellForSelectedFavoriteCell() {
        // Given
        sut.model = MockGenerator.createMovieBusinessModel()
        var indexPath: IndexPath?
        
        // When
        indexPath = sut.getIndexPathOfTableCellForSelectedFavoriteCell(indexPath: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertNotNil(indexPath)
    }
    
    func test_ShouldOrderWatchedMovies() {
        // Given
        sut.model = MockGenerator.createNonOrderedMovieBusinessModel()
        
        // When
        let firstMovie = sut.model.watchedMovies!.first
        let secondMovie = sut.model.watchedMovies![1]
        
        // Then
        XCTAssertEqual(firstMovie?.rating, firstMovie?.rating)
        XCTAssert(firstMovie!.title < secondMovie.title)
    }
    
    func test_ShouldOrderToWatchMovies() {
        // Given
        sut.model = MockGenerator.createNonOrderedMovieBusinessModel()
        
        // When
        let firstMovie = sut.model.toWatchMovies!.first
        let secondMovie = sut.model.toWatchMovies![1]
        
        // Then
        XCTAssertEqual(firstMovie?.rating, firstMovie?.rating)
        XCTAssert(firstMovie!.title < secondMovie.title)
    }
    
    func test_ShouldReturnFavoriteMovieIfFavoriteIdExist() {
        // Given
        sut.model = MockGenerator.createNonOrderedMovieBusinessModel()
        
        //Then
        XCTAssertNotNil(sut.model.favoriteList)
    }
    
    class MockBusinessController: MoviesBusinessController {
        override func getFavs(completion: @escaping (Result<Favorites, NetworkError>) -> Void) {
            completion(.success(MockGenerator.createFavorites()))
        }
        
        override func getMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
            completion(.success(MockGenerator.createMovieList()))
        }
    }
}
