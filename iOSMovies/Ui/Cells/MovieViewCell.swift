//
//  MovieViewCell.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 13/03/24.
//

import UIKit
import SwiftUI
import Kingfisher

class MovieViewCell: UICollectionViewCell {
    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title Movie"
        label.textAlignment = .center
        return label
    }()
        
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4.5"
        
        return label
    }()
        
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        ///kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg
        ///hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg
        loadImage(imageUrl: "https://image.tmdb.org/t/p/w500/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg")
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        let image = UIImage(systemName:"star.fill")!
        image.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            //imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -18),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            
        ])
    }
    
    func loadImage(imageUrl: String) {
        imageView.kf.setImage(with: URL(string: imageUrl))
    }
}

struct CustomCollectionViewCellPreview: PreviewProvider {
    static var previews: some View {
        // Use a UIViewRepresentable to wrap the UICollectionViewCell
        UIViewPreview {
            MovieViewCell()
        }
    }
}

// UIViewRepresentable wrapper for UICollectionViewCell
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> View {
        return view
    }
    
    func updateUIView(_ uiView: View, context: Context) {}
}


