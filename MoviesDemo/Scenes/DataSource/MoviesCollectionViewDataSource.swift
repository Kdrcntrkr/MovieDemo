//
//  MoviesCollectionViewDataSource.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 3.02.2022.
//

import Foundation
import UIKit

class MoviesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var movies: [Movie]?
    
    func registerCells(to collectionView: UICollectionView) {
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        guard let favModel = movies?[indexPath.row] else { return UICollectionViewCell()}
        let cellModel = MovieCollectionViewCell.Model(id: favModel.id,
                                                      title: favModel.title,
                                                      posterImagePath: favModel.imageUrl)
        cell.config(model: cellModel)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
