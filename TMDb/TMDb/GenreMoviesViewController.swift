//
//  GenreMoviesViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/28/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

class GenreMoviesViewController: UIViewController {
    let names = ["asas","sds","sdsd"]
    var genreMovies = [GenreMovie]()
    let indicatorView = UIActivityIndicatorView()
    var viewModel:GenreMoviesViewModelProtocol? {
        didSet{
            viewModel?.delegate = self
        }
    }
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var genreID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.startAnimating()
        viewModel = GenreMoviesViewModel()
        viewModel?.fetchGenreMovies(by: genreID)
        setupSubviews()
        setupConstraints()
        setupStyle()
        
    }
    func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GenreMoviesCollectionViewCell.self)
        collectionView.register(GenreMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupStyle() {
        collectionView.backgroundColor = .white
        collectionView.setCollectionViewLayout(layout, animated: true)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3)-10, height: (UIScreen.main.bounds.height/4)-10)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
    }
    
    
}

extension GenreMoviesViewController: GenreMoviesViewModelDelegate {
    func performOnFetch(genreMovies: [GenreMovie]) {
        DispatchQueue.main.async {
            self.genreMovies = genreMovies
            self.collectionView.reloadData()
            self.indicatorView.stopAnimating()
        }
    }
    
    func performOnError(_ error: Error) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            let alertController = UIAlertController(title: "Ошибка", message: "Возникла проблема при загрузке данных", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
}

extension GenreMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GenreMoviesCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let url = "https://image.tmdb.org/t/p/w500"
        guard let posterPath = genreMovies[indexPath.row].posterPath else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        }
        let urlImage = url+posterPath
        guard let imageUrl = URL(string: urlImage) else { return UICollectionViewCell() }
        guard let imageData = try? Data(contentsOf: imageUrl) else { return UICollectionViewCell() }
        var image = UIImage()
        if let data = imageData as? Data {
            image = UIImage(data: data) ?? UIImage()
        } else {
            image = UIImage()
        }
        cell.imageView.image = image
        return cell
    }
}
