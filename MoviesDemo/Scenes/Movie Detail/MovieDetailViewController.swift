//
//  MovieDetailViewController.swift
//  MoviesDemo
//
//  Created by Kadircan Türker on 4.02.2022.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    private(set) lazy var detailView = MovieDetailView()
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        detailView.posterImageView.kf.setImage(with: movie.imageUrl, placeholder: nil)
        detailView.movieNameLabel.text = movie.title
        detailView.descriptionLabel.attributedText = createAttributedString(with: "Description: ", normal: movie.overview)
        detailView.ratingLabel.attributedText = createAttributedString(with: "Rating: ", normal: "\(movie.rating)")
        detailView.languageLabel.attributedText = createAttributedString(with: "Language: ", normal: movie.originalLanguage.rawValue)
    }
}

private extension MovieDetailViewController {
    func createAttributedString(with bold: String, normal: String) -> NSAttributedString {
        let normalAttrString = NSMutableAttributedString(string: normal)
        let boldAttr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let boldStr = NSMutableAttributedString(string: bold, attributes: boldAttr)
        boldStr.append(normalAttrString)
        return boldStr
    }
}
