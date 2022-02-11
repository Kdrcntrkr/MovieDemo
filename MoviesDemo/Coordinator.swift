//
//  Coordinator.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
