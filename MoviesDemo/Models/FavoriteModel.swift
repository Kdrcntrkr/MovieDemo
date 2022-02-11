//
//  FavoriteModel.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 5.02.2022.
//

import Foundation

struct Favorites: Codable {
    let results: [Favs]
}

struct Favs: Codable {
    let id: Int
}
