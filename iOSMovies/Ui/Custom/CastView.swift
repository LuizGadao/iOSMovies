//
//  CastView.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 19/03/24.
//

import UIKit
import SwiftUI

class CastView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    private lazy var primaryColor: UIColor? = nil
    
    private let titleLabel = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collection.showsHorizontalScrollIndicator = false
        
        return collection
    } ()
    
    var items = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setColor(color: UIColor) {
        primaryColor = color
        titleLabel.textColor = color
    }
    
    private func setupViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .colorTitle
        titleLabel.text = "Cast"
        addSubview(titleLabel)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CastViewCell.self, forCellWithReuseIdentifier: "Cell")
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
            //collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        items = [
            "BE2sdjpgsa2rNTFa66f7upkaOP.jpg",
            "tylFh0K48CZIIhvKlA7WA1XBAtE.jpg",
            "lJloTOheuQSirSLXNA3JHsrMNfH.jpg",
            "IShnFg6ijWhpbu29dFBd9PtqQg.jpg",
            "sX2etBbIkxRaCsATyw5ZpOVMPTD.jpg",
            "jn63A9goIetyvJt5DTHypjk33ip.jpg",
            "BE2sdjpgsa2rNTFa66f7upkaOP.jpg",
            "tylFh0K48CZIIhvKlA7WA1XBAtE.jpg",
            "lJloTOheuQSirSLXNA3JHsrMNfH.jpg",
            "IShnFg6ijWhpbu29dFBd9PtqQg.jpg",
            "sX2etBbIkxRaCsATyw5ZpOVMPTD.jpg",
            "jn63A9goIetyvJt5DTHypjk33ip.jpg"
        ]
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CastViewCell else {
            fatalError("error to create cast cell")
        }
        
        cell.loadImage(
            imageUrl: "https://image.tmdb.org/t/p/w300/\(items[indexPath.row])"
        )
        
        if primaryColor != nil {
            cell.setColor(color: primaryColor!)
        }
        
        return cell
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80) // Adjust item size as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust minimum interitem spacing as needed
    }
}

struct CustomViewPreview: PreviewProvider {
    static var previews: some View {
        CustomViewRepresentable()
            .previewLayout(.fixed(width: 300, height: 200)) // Adjust the size as needed
    }
}

struct CustomViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return CastView(frame: CGRect(x: 0, y: 0, width: 300, height: 200)) // Adjust the size as needed
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }
}

