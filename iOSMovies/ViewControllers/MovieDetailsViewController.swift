//
//  MovieDetailsViewController.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 15/03/24.
//

import UIKit
import SwiftUI

class MovieDetailsViewController: UIViewController {

    var movie: Movie
    
    private var primaryColor = UIColor.blue
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 32
        image.layer.masksToBounds = true
        
        return image
    }()
    
    private lazy var star: UIImageView = {
        let image = UIImageView(image: UIImage.star1)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        label.textColor = primaryColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        //label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var synopisisLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .lightGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let iconImage = UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(iconImage, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.6)
        let inset: CGFloat = 0 // Adjust as needed
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        button.layer.cornerRadius = 20

        //button.addTarget(self, action: #selector(onClickFavoriteButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let iconImage = UIImage(systemName: "arrowshape.turn.up.backward.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(iconImage, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.5)
        let inset: CGFloat = 0 // Adjust as needed
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        
        titleLabel.text = movie.title
        infoLabel.text = "info hereee..."
        synopisisLabel.text = "synopisis here..."
        rateLabel.text = "4.7"
        
        let imagePreview = "kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg"
        var strPath = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? imagePreview)"
        
        image.kf.setImage(with: URL(string: strPath))
    }
    
    private func addViews() {
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(synopisisLabel)
        view.addSubview(star)
        view.addSubview(rateLabel)
        view.addSubview(favoriteButton)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:0),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            image.heightAnchor.constraint(equalToConstant: 290),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            
            star.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            star.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            star.widthAnchor.constraint(equalToConstant: 22.0),
            star.heightAnchor.constraint(equalToConstant: 22.0),
            
            rateLabel.topAnchor.constraint(equalTo: star.topAnchor, constant: 2),
            rateLabel.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 6),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            synopisisLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 16),
            synopisisLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            synopisisLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            favoriteButton.topAnchor.constraint(equalTo: image.topAnchor, constant: 24),
            favoriteButton.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: image.topAnchor, constant: 24),
            backButton.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

struct CustomViewDetailPreview: PreviewProvider {
    static var previews: some View {
        // Use a UIViewRepresentable to wrap the UICollectionViewCell
        MyViewControllerWrapper()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

// UIViewRepresentable wrapper for UICollectionViewCell
struct MyViewControllerWrapper<View: UIView>: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        // Instantiate your UIKit view controller here
        
        let jsonString = """
        {
            "adult": false,
            "backdrop_path": "/gJL5kp5FMopB2sN4WZYnNT5uO0u.jpg",
            "genre_ids": [28, 12, 16, 35, 10751],
            "id": 1011985,
            "original_language": "en",
            "original_title": "Kung Fu Panda 4",
            "overview": "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
            "popularity": 1652.671,
            "poster_path": "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg",
            "release_date": "2024-03-02",
            "title": "Kung Fu Panda 4",
            "video": false,
            "vote_average": 6.993,
            "vote_count": 68
        }
        """
        
        // Convert the JSON string to data
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Failed to convert JSON string to data")
        }

        // Decode the JSON data into a Movie object
        var movie: Movie?
        do {
            movie = try JSONDecoder().decode(Movie.self, from: jsonData)
            let viewController = MovieDetailsViewController(movie: movie!)
            return viewController
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        //let viewController = MovieDetailsViewController(movie: movie)
        return MovieDetailsViewController(movie: movie!)
    }
        
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}
