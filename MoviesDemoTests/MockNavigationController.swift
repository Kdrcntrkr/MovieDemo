//
//  MockNavigationController.swift
//  MoviesDemoTests
//
//  Created by Kadircan Türker on 4.02.2022.
//

import Foundation

import UIKit

class MockNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}
