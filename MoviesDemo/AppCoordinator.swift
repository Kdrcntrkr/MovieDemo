//
//  AppCoordinator.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var moviesCoordinator: MoviesCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        moviesCoordinator = MoviesCoordinator(navigationController: navigationController)
        moviesCoordinator?.start()
    }
}
