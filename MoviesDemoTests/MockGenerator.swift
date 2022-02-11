//
//  MockGenerator.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 4.02.2022.
//

import Foundation
@testable import MoviesDemo

class MockGenerator {
    static func createMovieList() -> MovieList {
        return MovieList(results: [Movie(backdropPath: "", id: 0, originalLanguage: .en, originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "A", rating: 1, isWatched: true),
                                   Movie(backdropPath: "", id: 1, originalLanguage: .en, originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "C", rating: 6, isWatched: true),
                                   Movie(backdropPath: "", id: 2, originalLanguage: .en, originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "B", rating: 6, isWatched: true),
                                   Movie(backdropPath: "", id: 3, originalLanguage: .en, originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "A", rating: 2, isWatched: false),
                                   Movie(backdropPath: "", id: 4, originalLanguage: .en, originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "C", rating: 1, isWatched: false),
                                   Movie(backdropPath: "", id: 5, originalLanguage: .en, originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "B", rating: 1, isWatched: false)])
    }
    
    static func createFavorites() -> Favorites {
        return Favorites(results: [Favs(id: 0)])
    }
    
    static func createMovie(with id: Int = 0) -> Movie {
        return Movie(backdropPath: "", id: id, originalLanguage: .en, originalTitle: "", overview: "Test", popularity: 0, posterPath: "", releaseDate: "", title: "Test", rating: 1, isWatched: true)
    }
    
    static func createMovieBusinessModel() -> MoviesBusinessController.Model {
        return MoviesBusinessController.Model(favorites: [Favs(id: 0)], movieList: [createMovie(), createMovie(with: 1)])
    }
    
    static func createNonOrderedMovieBusinessModel() -> MoviesBusinessController.Model {
        return MoviesBusinessController.Model(favorites: [Favs(id: 0)], movieList: createMovieList().results)
    }
}
