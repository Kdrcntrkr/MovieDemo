//
//  MoviesBusinessController.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import Foundation

class MoviesBusinessController {
    
    let networkManager: NetworkManager
    var model = Model(favorites: nil, movieList: nil)
    var lastSelectedIndexPath: IndexPath?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getFavs(completion: @escaping (Result<Favorites, NetworkError>) -> Void) {
        networkManager.sendRequest(request: .fetchFavorites, responseType: Favorites.self) { result in
            switch result {
            case .success(let favs):
                completion(.success(favs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        networkManager.sendRequest(request: .fetchMovies, responseType: MovieList.self) { result in
            switch result {
            case .success(let movieList):
                completion(.success(movieList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMoviesAndFavorites(completion: @escaping (Model) -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        getMovies { [weak self] result in
            guard let self = self else { return }
            if case .success(let movies) = result {
                self.model.movieList = movies.results
            }
            group.leave()
        }
        
        group.enter()
        getFavs { [weak self] result in
            guard let self = self else { return }
            if case .success(let favs) = result {
                self.model.favorites = favs.results
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            completion(self.model)
        }
    }
    
    func getSelectedMovie(from indexPath: IndexPath) -> Movie? {
        if indexPath.section == 0 {
            return model.watchedMovies?[indexPath.row]
        } else {
            return model.toWatchMovies?[indexPath.row]
        }
    }
    
    func getIndexPathOfFavoriteCellfForSelectedTableCell(indexPath: IndexPath) -> IndexPath? {
        let isWatched = indexPath.section == 0
        guard let selectedMovieId = isWatched ? model.watchedMovies?[indexPath.row].id : model.toWatchMovies?[indexPath.row].id else { return nil }
        guard let favIndex = model.favoriteList?.firstIndex(where: {$0.id == selectedMovieId}) else { return nil }
        lastSelectedIndexPath = IndexPath(row: favIndex, section: 0)
        return lastSelectedIndexPath
    }
    
    func getIndexPathOfTableCellForSelectedFavoriteCell(indexPath: IndexPath) -> IndexPath? {
        guard let selectedMovie = model.favoriteList?[indexPath.row] else { return nil }
        lastSelectedIndexPath = IndexPath(row: indexPath.row, section: 0)
        if selectedMovie.isWatched {
            guard let index = model.watchedMovies?.firstIndex(where: {$0.id == selectedMovie.id}) else { return nil }
            return IndexPath(row: index, section: 0)
        } else {
            guard let index = model.toWatchMovies?.firstIndex(where: {$0.id == selectedMovie.id}) else { return nil }
            return IndexPath(row: index, section: 1)
        }
    }
}

extension MoviesBusinessController {
    struct Model {
        fileprivate var favorites: [Favs]?
        fileprivate var movieList: [Movie]?
        
        init(favorites: [Favs]?, movieList: [Movie]?) {
            self.favorites = favorites
            self.movieList = movieList
        }
        
        var favoriteList: [Movie]? {
            var favoriteMovies: [Movie] = []
            for item in favorites ?? [] {
                guard let favMovie = movieList?.first(where: {$0.id == item.id}) else { return nil }
                favoriteMovies.append(favMovie)
            }
            return favoriteMovies
        }
        
        var watchedMovies: [Movie]? {
            return movieList?.filter{$0.isWatched}.sorted { (first, second) in
                if first.rating == second.rating {
                    return first.title < second.title
                }
                return first.rating > second.rating
            }
        }
        
        var toWatchMovies: [Movie]? {
            return movieList?.filter{!$0.isWatched}.sorted { (first, second) in
                if first.rating == second.rating {
                    return first.title < second.title
                }
                return first.rating > second.rating
            }
        }
    }
}
