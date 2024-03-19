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
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    } ()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    } ()
    
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
        label.font = .systemFont(ofSize: 38.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.0)
        //label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var synopisisTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Prolog"
        return label
    }()
    
    private lazy var synopisisLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28.0)
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
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        setupViews()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(synopisisLabel)
        contentView.addSubview(synopisisTitle)
        contentView.addSubview(star)
        contentView.addSubview(rateLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(backButton)
    }
    
    private func setupViews() {
        titleLabel.text = movie.title
        infoLabel.text = "| Release date: \(movie.releaseDate) \n| Original title: \(movie.originalTitle)\n| Popularity: \(movie.popularity)"
        synopisisLabel.text = movie.overview //"synopisis here..."
        rateLabel.text = "4.7"
        
        let imagePreview = "kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg"
        let strPath = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? imagePreview)"
        
        image.kf.setImage(with: URL(string: strPath))
        
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
    
    @objc private func onClickBackButton(sender: UIButton) {
        print("on click back button")
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupConstraints() {
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant:0),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            image.heightAnchor.constraint(equalToConstant: 310),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            
            star.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 26),
            star.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            star.widthAnchor.constraint(equalToConstant: 22.0),
            star.heightAnchor.constraint(equalToConstant: 22.0),
            
            rateLabel.topAnchor.constraint(equalTo: star.topAnchor, constant: 2),
            rateLabel.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 6),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            synopisisTitle.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 16),
            synopisisTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            synopisisTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            synopisisLabel.topAnchor.constraint(equalTo: synopisisTitle.bottomAnchor, constant: 16),
            synopisisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            synopisisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            synopisisLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            
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
