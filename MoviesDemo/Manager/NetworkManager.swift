//
//  NetworkManager.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import Foundation

class NetworkManager {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T: Decodable>(request: Request, responseType: T.Type, completion: @escaping ((Result<T, NetworkError>) -> Void)) {
        
        guard let urlComponents = URLComponents(string: request.baseURL) else { return completion(.failure(.urlFailure))}
        guard let requestUrl = urlComponents.url else {
            return completion(.failure(.urlFailure))
        }
        
        let request = URLRequest(url: requestUrl)
        
        let task = urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                return completion(.failure(.somethingWentWrong(error)))
            }
            guard let data = data, !data.isEmpty else {
                return completion(.failure(.noData))
            }
            
            do {
                let response = try JSONDecoder().decode(responseType.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case noData
    case somethingWentWrong(Error?)
    case parseError
    case urlFailure
}

enum Request {
    case fetchMovies
    case fetchFavorites
    
    var baseURL: String {
        switch self {
        case .fetchMovies:
            return "https://61efc467732d93001778e5ac.mockapi.io/movies/list"
        case .fetchFavorites:
            return "https://61efc467732d93001778e5ac.mockapi.io/movies/favorites"
        }
    }
    
    var method: String {
        return "GET"
    }
}
