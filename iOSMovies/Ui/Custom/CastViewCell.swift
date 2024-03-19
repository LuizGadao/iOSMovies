//
//  CastViewCell.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 19/03/24.
//

import UIKit
import SwiftUI

class CastViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.colorTitle.cgColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add imageView to cell's contentView
        contentView.addSubview(imageView)
        
        // Set constraints for imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
            //imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // to preview
        loadImage(imageUrl: "https://image.tmdb.org/t/p/w300/BE2sdjpgsa2rNTFa66f7upkaOP.jpg")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(color: UIColor) {
        imageView.layer.borderColor = color.cgColor
    }
    
    func loadImage(imageUrl: String) {
        let placeHolder = UIImage(systemName: "photo.fill")
        imageView.kf.setImage(
            with: URL(string: imageUrl),
            placeholder: placeHolder,
            options: [
                .transition(.fade(0.3))
            ]
        )
    }
}

struct CustomCollectionViewCastPreview: PreviewProvider {
    static var previews: some View {
        // Use a UIViewRepresentable to wrap the UICollectionViewCell
        UIViewPreview {
            CastViewCell()
        }
    }
}

struct UIViewCellPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> View {
        return view
    }
    
    func updateUIView(_ uiView: View, context: Context) {}
}
