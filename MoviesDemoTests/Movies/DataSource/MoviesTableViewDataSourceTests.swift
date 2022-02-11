//
//  MoviesTableViewDataSourceTests.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 5.02.2022.
//

import XCTest
@testable import MoviesDemo

class MoviesTableViewDataSourceTests: XCTestCase {

    var sut: MoviesTableViewDataSource!
    var tableView: UITableView!
    var model: MoviesBusinessController.Model?
    
    override func setUp() {
        super.setUp()
        sut = MoviesTableViewDataSource()
        tableView = UITableView()
        model = MockGenerator.createMovieBusinessModel()
    }
    
    override func tearDown() {
        model = nil
        tableView = nil
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldRegisterTableViewCell() {
        // Given
        sut.model = model
        sut.registerCells(to: tableView)
        let indexPath = IndexPath(item: 0, section: 0)

        // When
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        //Then
        XCTAssertTrue(cell is MovieTableViewCell)
    }
    
    func test_ShouldConfigureCell() {
        // Given
        sut.model = model
        sut.registerCells(to: tableView)

        // When
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieTableViewCell
        
        //Then
        XCTAssertEqual(cell?.titleLabel.text, model?.watchedMovies?.first?.title)
    }

}
