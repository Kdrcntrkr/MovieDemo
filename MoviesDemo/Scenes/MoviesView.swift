//
//  MoviesView.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 2.02.2022.
//

import Foundation
import UIKit
import SnapKit

class MoviesView: UIView {
    lazy var favoriteTitleLabel = makeFavoriteTitleLabel()
    lazy var collectionView = makeCollectionView()
    lazy var tableView = makeTableView()
    lazy var nextButton = makeNextButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension MoviesView {
    func layoutViews() {
        
        addSubview(favoriteTitleLabel)
        favoriteTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(50)
            make.trailing.equalTo(self).offset(-50)
            make.bottom.equalTo(self).offset(-25)
            make.height.equalTo(50)
        }
    }
    
    func makeFavoriteTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        return label
    }
    
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        
        return collectionView
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }
    
    func makeNextButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        return button
    }
}
