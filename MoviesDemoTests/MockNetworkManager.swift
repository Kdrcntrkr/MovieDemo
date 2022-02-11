//
//  MockNetworkManager.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 4.02.2022.
//

import Foundation
@testable import MoviesDemo

class MockNetworkManager: NetworkManager {
    enum Status { case success, error }
    enum DataType { case movies, favorites }
    var status: Status = .success
    var dataType: DataType = .movies
    
    override func sendRequest<T>(request: Request, responseType: T.Type, completion: @escaping ((Result<T, NetworkError>) -> Void)) where T : Decodable {
        switch status {
        case .success:
            switch dataType {
            case .movies:
                completion(.success(MockGenerator.createMovieList() as! T))
            case .favorites:
                completion(.success(MockGenerator.createFavorites() as! T))
            }
        case .error:
            completion(.failure(.somethingWentWrong(nil)))
        }
    }
}
