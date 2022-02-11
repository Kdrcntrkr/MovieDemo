//
//  MovieModel.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import Foundation

struct MovieList: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let backdropPath: String
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let rating: Double
    let isWatched: Bool
    var imageUrl: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, rating, isWatched
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case ru = "ru"
}
