//
//  MovieCollectionViewCell.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 3.02.2022.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    lazy var containerView = makeContainerView()
    lazy var posterImageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    func config(model: Model) {
        if let url = model.posterImagePath {
            posterImageView.kf.setImage(with: url, placeholder: nil)
        }
        titleLabel.text = model.title
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                addLayer()
            } else {
                removeLayer()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MovieCollectionViewCell {
    func layoutViews() {
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(15)
            make.trailing.bottom.equalTo(self).offset(-15)
        }
        
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
            make.centerX.equalTo(containerView.snp.centerX)
            make.height.equalTo(posterImageView.snp.width)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(5)
            make.trailing.equalTo(containerView.snp.trailing).offset(-5)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
        }
        
    }
    
    func makeContainerView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .gray
        return view
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10)
        return label
    }
    
    func addLayer() {
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func removeLayer() {
        containerView.layer.borderWidth = 0
    }
}

extension MovieCollectionViewCell {
    struct Model {
        let id: Int
        let title: String
        let posterImagePath: URL?
    }
}
