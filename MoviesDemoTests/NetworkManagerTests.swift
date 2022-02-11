//
//  NetworkManagerTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 4.02.2022.
//

import XCTest
@testable import MoviesDemo

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var session: MockURLSession!
    var url: URL!
    var movieList: MovieList!
    var favorites: Favorites!
    
    override func setUp() {
        super.setUp()
        url = URL(fileURLWithPath: "url")
        session = MockURLSession()
        sut = NetworkManager(urlSession: session)
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        url = nil
        movieList = nil
        favorites = nil
        super.tearDown()
    }
    
    func test_ShouldReturnDataFromMovieList() {
        // Given
        let fetchDataExpectation = expectation(description: "Fetch Data")

        let data = MockGenerator.createMovieList()
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        session.data = try? JSONEncoder().encode(data)
        session.response = response
        sut = NetworkManager(urlSession: session)
        // When
        sut.sendRequest(request: .fetchMovies, responseType: MovieList.self) { result in
            if case let .success(data) = result {
                self.movieList = data
            }
            fetchDataExpectation.fulfill()
        }

        //Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertNotNil(movieList)
    }
    
    func test_ShouldReturnDataFromFavorites() {
        // Given
        let fetchDataExpectation = expectation(description: "Fetch Data")

        let data = MockGenerator.createFavorites()
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        session.data = try? JSONEncoder().encode(data)
        session.response = response
        sut = NetworkManager(urlSession: session)
        // When
        sut.sendRequest(request: .fetchFavorites, responseType: Favorites.self) { result in
            if case let .success(data) = result {
                self.favorites = data
            }
            fetchDataExpectation.fulfill()
        }

        //Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertNotNil(favorites)
    }
    

    class MockURLSession: URLSession {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let data = self.data
            let response = self.response
            let error = self.error

            return URLSessionDataTaskMock {
                completionHandler(data, response, error)
            }
        }
    }

    class URLSessionDataTaskMock: URLSessionDataTask {
        private let closure: () -> Void
        init(closure: @escaping () -> Void) {
            self.closure = closure
        }

        override func resume() {
            closure()
        }
    }
}
