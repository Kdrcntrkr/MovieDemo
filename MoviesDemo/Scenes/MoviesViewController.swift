//
//  MoviesViewController.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import Foundation
import UIKit

protocol MoviesViewControllerDelegate: AnyObject {
    func moviesViewControllerDidTapNext(_ moviesViewController: MoviesViewController, for movie: Movie)
}

class MoviesViewController: UIViewController {
    private(set) lazy var moviesView = MoviesView()
    
    let businessController: MoviesBusinessController
    let tableDataSource: MoviesTableViewDataSource
    let collectionDataSource: MoviesCollectionViewDataSource
    
    weak var delegate: MoviesViewControllerDelegate?
    
    init(businessController: MoviesBusinessController,
         tableDataSource: MoviesTableViewDataSource,
         collectionDataSource: MoviesCollectionViewDataSource) {
        self.businessController = businessController
        self.tableDataSource = tableDataSource
        self.collectionDataSource = collectionDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fetchMovies()
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = businessController.getIndexPathOfFavoriteCellfForSelectedTableCell(indexPath: indexPath) else {
            return deselectCollectionCellIfNeeded()
        }
        moviesView.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedIndexPath = businessController.getIndexPathOfTableCellForSelectedFavoriteCell(indexPath: indexPath) else { return }
        moviesView.tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width / 4
        return CGSize(width: width, height: height)
    }
}

private extension MoviesViewController {
    func config() {
        moviesView.nextButton.addTarget(self, action: #selector(openDetail), for: .touchUpInside)
        
        moviesView.favoriteTitleLabel.text = "Favorites"
        
        tableDataSource.registerCells(to: moviesView.tableView)
        moviesView.tableView.dataSource = tableDataSource
        moviesView.tableView.delegate = self
        
        collectionDataSource.registerCells(to: moviesView.collectionView)
        moviesView.collectionView.dataSource = collectionDataSource
        moviesView.collectionView.delegate = self
    }
    
    @objc
    func openDetail() {
        guard let indexPath = moviesView.tableView.indexPathForSelectedRow,
              let selectedMovie = businessController.getSelectedMovie(from: indexPath) else { return }
        delegate?.moviesViewControllerDidTapNext(self, for: selectedMovie)
    }
    
    func fetchMovies() {
        businessController.fetchMoviesAndFavorites { [weak self] result in
            self?.tableDataSource.model = result
            self?.collectionDataSource.movies = result.favoriteList
            self?.moviesView.tableView.reloadData()
            self?.moviesView.collectionView.reloadData()
            
        }
    }
    
    func deselectCollectionCellIfNeeded() {
        if let selectedIndex = businessController.lastSelectedIndexPath {
            moviesView.collectionView.deselectItem(at: selectedIndex, animated: false)
        }
    }
}
