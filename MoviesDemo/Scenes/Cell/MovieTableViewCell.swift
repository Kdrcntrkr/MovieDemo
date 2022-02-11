//
//  MovieTableViewCell.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 3.02.2022.
//

import Foundation
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    lazy var containerView = makeContainerView()
    lazy var posterImageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
        selectionStyle = .none
    }
    
    func config(model: Model) {
        if let url = model.posterImagePath {
            posterImageView.kf.setImage(with: url, placeholder: nil)
        }
        
        titleLabel.text = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            addLayer()
        } else {
            removeLayer()
        }
    }
}

private extension MovieTableViewCell {
    func layoutViews() {
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.top.equalTo(self).offset(10)
            make.trailing.bottom.equalTo(self).offset(-10)
        }
        
        addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.top.equalTo(containerView.snp.top).offset(10)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
            make.centerY.equalTo(containerView.snp.centerY)
            make.height.equalTo(posterImageView.snp.width)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.centerY.equalTo(posterImageView.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }
    }
    
    func makeContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
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

extension MovieTableViewCell {
    struct Model {
        let id: Int
        let title: String
        let posterImagePath: URL?
    }
}
