//
//  MoviesTableViewDataSource.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 3.02.2022.
//

import Foundation
import UIKit
import CoreMIDI

class MoviesTableViewDataSource: NSObject, UITableViewDataSource {
    
    var model: MoviesBusinessController.Model?
    
    func registerCells(to tableView: UITableView) {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return model?.watchedMovies?.count ?? 0
        case 1:
            return model?.toWatchMovies?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        if indexPath.section == 0 {
            guard let model = model?.watchedMovies?[indexPath.row] else { return UITableViewCell() }
            let cellModel = MovieTableViewCell.Model(id: model.id,
                                                     title: model.title,
                                                     posterImagePath: model.imageUrl)
            cell.config(model: cellModel)
        } else {
            guard let model = model?.toWatchMovies?[indexPath.row] else { return UITableViewCell() }
            let cellModel = MovieTableViewCell.Model(id: model.id,
                                                     title: model.title,
                                                     posterImagePath: model.imageUrl)
            cell.config(model: cellModel)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Watched"
        case 1:
            return "To Watch"
        default:
            return ""
        }
    }
}
