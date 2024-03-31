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
    private var remote = NetworkdDataSource()
    
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
        label.textColor = .colorTitle
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20.0)
        //label.font = .italicSystemFont(ofSize: 22)
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
        label.textColor = .colorTitle
        label.numberOfLines = 0
        label.text = "Prolog"
        return label
    }()
    
    private lazy var castView: CastView = {
        let cast = CastView()
        cast.translatesAutoresizingMaskIntoConstraints = false
        return cast
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
        
        button.layer.cornerRadius = 20
        return button
    }()
    
    var backIcon = UIImage(systemName:"arrowshape.turn.up.backward.fill")?
        .withTintColor(.colorTitle.withAlphaComponent(0.7), renderingMode: .alwaysOriginal)
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(backIcon, for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.5)
        
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        setupViews()
        
        Task {
            await getCreditMovie()
        }
    }
    
    private func getCreditMovie() async {
        do {
            let movieCredit = try await remote.getMovieCredit(movieId: movie.id)
            let actorsWithImage = movieCredit.cast.filter{ $0.profilePath != nil }
            let images = actorsWithImage.map{ $0.profilePath! }
            
            castView.images = images
        } catch(let error) {
            print("error load credit movie: \(error)")
        }
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
        contentView.addSubview(castView)
    }
    
    private func setupViews() {
        titleLabel.text = movie.title
        infoLabel.text = """
        | Data de lançamento: \(formatDateToBr(date: movie.releaseDate))
        | Título original: \(movie.originalTitle)
        | Popularidade: \(movie.popularity)
        """
        synopisisLabel.text = movie.overview //"synopisis here..."
        rateLabel.text = String(format: "%.1f", movie.voteAverage)
        
        let imagePreview = "kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg"
        let strPath = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? imagePreview)"
        
        let placeHolder = UIImage(systemName: "photo.fill")
        image.kf.setImage(
            with: URL(string: strPath),
            placeholder: placeHolder,
            options: [
                .transition(.fade(0.3))
            ]
        ) { result in
            
            switch result {
            case .success(let value) :
                let colors = self.extractColors(count: 1)
                let color = value.image.averageColor ?? .blue
                
                self.tintComponents(colors: [color, colors[0]])
                print("dominant colors: ", color)
                
            case .failure(_) :
                print("error loading image")
            }
            
        }
        
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
    
    private func extractColors(count: Int) -> [UIColor] {
        let numberOfColors = count
        var colors: [UIColor] = []
        for _ in 0..<numberOfColors {
            let red = CGFloat.random(in: 0...1)
            let green = CGFloat.random(in: 0...1)
            let blue = CGFloat.random(in: 0...1)
            colors.append(UIColor(red: red, green: green, blue: blue, alpha: 1.0))
        }
        return colors
    }
    
    private func tintComponents(colors:[UIColor]) {
        var tintedImage = UIImage(systemName:"arrowshape.turn.up.backward.fill")?
            .withTintColor(colors[0].withAlphaComponent(1), renderingMode: .alwaysOriginal)
        self.backButton.setImage(tintedImage, for: .normal)
        
        tintedImage = UIImage(systemName:"heart")?
            .withTintColor(colors[0].withAlphaComponent(1), renderingMode: .alwaysOriginal)
        self.favoriteButton.setImage(tintedImage, for: .normal)
        
        self.titleLabel.textColor = colors[0]
        self.synopisisTitle.textColor = colors[0]
        self.castView.setColor(colors: colors)
    }
    
    @objc private func onClickBackButton(sender: UIButton) {
        print("on click back button")
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func formatDateToBr(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: date) {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            
            return dateFormater.string(from: date)
        }
        
        return date
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
            
            star.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 26),
            star.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            star.widthAnchor.constraint(equalToConstant: 22.0),
            star.heightAnchor.constraint(equalToConstant: 22.0),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: star.trailingAnchor, constant: -12),
            
            rateLabel.topAnchor.constraint(equalTo: star.topAnchor, constant: 2),
            rateLabel.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 6),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            castView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 16),
            castView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            castView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            castView.heightAnchor.constraint(equalToConstant: 145),
            
            synopisisTitle.topAnchor.constraint(equalTo: castView.bottomAnchor, constant: 16),
            synopisisTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            synopisisTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            synopisisLabel.topAnchor.constraint(equalTo: synopisisTitle.bottomAnchor, constant: 16),
            synopisisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            synopisisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            synopisisLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            
            favoriteButton.topAnchor.constraint(equalTo: image.topAnchor, constant: 44),
            favoriteButton.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            backButton.topAnchor.constraint(equalTo: image.topAnchor, constant: 44),
            backButton.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(
            red: CGFloat(bitmap[0]) / 255,
            green: CGFloat(bitmap[1]) / 255,
            blue: CGFloat(bitmap[2]) / 255,
            alpha: CGFloat(bitmap[3]) / 255
        )
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
            "original_title": "Kung Fu Panda 444",
            "overview": "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
            "popularity": 1652.671,
            "poster_path": "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg",
            "release_date": "2024-03-02",
            "title": "Kung Fu Panda 44",
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
