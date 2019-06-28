//
//  MovieImagesViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

class MovieImagesViewController: UIViewController {
    var viewModel: MovieImagesViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    let names = ["as","asa","asas"]
    var imageMovies = [ImageMovie]()
    var movieID: Int?
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
       
        
        setupSubviews()
        setupConstraints()
        setupStyle()
        viewModel = MovieImagesViewModel()
        if let movId = movieID {
            viewModel?.fetchMovieImages(by: movId)
            
        }
        print("movie id is fetched", movieID)
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.setCollectionViewLayout(layout, animated: true)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width)/3-10, height: (UIScreen.main.bounds.height)/4-10)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageMoviesCollectionViewCell.self)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
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
    }
}

extension MovieImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageMoviesCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        guard let posterPath = imageMovies[indexPath.row].file_path else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        }
        let url = "https://image.tmdb.org/t/p/w500"
        let urlImage = url+posterPath
        let imageURL = NSURL(string: urlImage )
        let imageData = NSData(contentsOf: imageURL as! URL)
        cell.imageView.image = UIImage(data: imageData as! Data)
        return cell
    }
    
}

extension MovieImagesViewController: MovieImagesViewModelDelegate {
    func performOnFetch(images: [ImageMovie]) {
        DispatchQueue.main.async {
            self.imageMovies = images
            self.collectionView.reloadData()
            print("Imagessssss sukakakakakakka", self.imageMovies)
        }
    }
    
    func performOnError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка", message: "Возникла проблема при загрузке данных", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ОК", style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    
    
    
    
}
