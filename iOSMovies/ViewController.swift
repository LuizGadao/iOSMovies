//
//  ViewController.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 13/03/24.
//

import UIKit

class ViewController: UIViewController {

    private var remote = NetworkdDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        Task {
            await getMovies()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        let mView = UIView()
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.backgroundColor = .blue
        
        view.addSubview(mView)
        
        NSLayoutConstraint.activate([
            mView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func getMovies() async {
        do {
            let moviesResponse =  try await remote.getMovies()
            print(moviesResponse.page)
            print(moviesResponse.results[0].originalTitle)
        } catch(let error) {
            printContent(error)
        }
    }
    
}

