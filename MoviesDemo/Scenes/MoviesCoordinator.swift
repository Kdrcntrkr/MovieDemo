//
//  MoviesCoordinator.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import UIKit

class MoviesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let businessController = MoviesBusinessController(networkManager: NetworkManager())
        let viewController = MoviesViewController(businessController: businessController,
                                                  tableDataSource: MoviesTableViewDataSource(),
                                                  collectionDataSource: MoviesCollectionViewDataSource())
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MoviesCoordinator: MoviesViewControllerDelegate {
    func moviesViewControllerDidTapNext(_ moviesViewController: MoviesViewController, for movie: Movie) {
        let viewController = MovieDetailViewController(movie: movie)
        navigationController.pushViewController(viewController, animated: true)
    }
}
