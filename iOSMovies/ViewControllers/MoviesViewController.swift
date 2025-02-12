//
//  ViewController.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 13/03/24.
//

import UIKit

class MoviesViewController: UIViewController {

    private var remote = NetworkdDataSource()
    var movies: [Movie] = []
    var isLoadingMovies = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 8, left: 8, bottom: 8, right: 8
        )
        let collection = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.register(
            MovieViewCell.self,
            forCellWithReuseIdentifier: "movie-cell"
        )
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadMovies()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadMovies() {
        Task {
            isLoadingMovies = true
            await getMovies()
        }
    }
    
    private func getMovies() async {
        do {
            let moviesResponse =  try await remote.getMovies()
            print(moviesResponse.page)
            print(moviesResponse.results[0].originalTitle)
            //movies = moviesResponse.results
            for mov in moviesResponse.results {
                print(mov.title)
            }
            
            movies += moviesResponse.results
            collectionView.reloadData()
            isLoadingMovies = false
        } catch(let error) {
            printContent(error)
        }
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie-cell", for: indexPath) as? MovieViewCell else {
            fatalError("error to create favorite movie cell")
        }
        
        // set image here
        //cell.loadImage(imageUrl: "")
        // register click
        //cell.delegate = self
        let posterImg = "https://image.tmdb.org/t/p/w500/\(movies[indexPath.item].posterPath!)"
        cell.loadImage(imageUrl: posterImg)
        cell.delegate = self
        
        return cell
    }
    
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = 182//119//collectionView.frame.width / 3 //172
        return CGSize(width: width, height: 202)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == (movies.count - 6) && !isLoadingMovies {
            print("load more data")
            loadMovies()
        }
    }

}

extension MoviesViewController : MovieViewCellDelegate {
    
    func onClickMovie(_ cell: UICollectionViewCell) {
        guard let index = collectionView.indexPath(for: cell) else  {
            return
        }
        
        let movie = movies[index.row]
        print("movie id: \(movie.id)")
        navigationController?.pushViewController(
            MovieDetailsViewController(movie: movie),
            animated: true
        )
    }
    
}

