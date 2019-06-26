//
//  MovieDetailViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

protocol MovieDelegate: class {
    func sendString(_ string: String)
}

class MovieDetailViewController: UIViewController {
    var viewModel: MovieDetailViewModelProtocol? {
        didSet { viewModel?.delegate = self }
    }
    var movieID : Int?
    let str = "567"
    
    weak var delegate: MovieDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = MovieDetailViewModel()
        if let id = movieID {
            viewModel?.fetchMovieDetail(by: id)
        }
        print("movie id is fetched", movieID)
        
        delegate?.sendString(str)
    }
    

}
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func performOnFetch(movie: [MovieDetail]) {
        DispatchQueue.main.async {
//            self.upcomingMovies = movies
//            self.collectionView.reloadData()
        }
    }
    
    
    func performOnError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка", message: "Возникла проблема при загрузке данных", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
}
