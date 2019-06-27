//
//  PopularViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/24/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit



class PopularViewController: UIViewController, MovieDelegate {
    
    func sendString(_ string: String) {
        print(string)
    }
    
    var viewModel: PopularViewModelProtocol? {
        didSet { viewModel?.delegate = self }
    }
    
    let names = ["sdsd","asas","asas"]
    var popularMovies = [PopularMovie]()
    
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let indicatorView = UIActivityIndicatorView(style: .gray)
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        setupSubviews()
        setupConstraints()
        setupStyle()
        
        indicatorView.startAnimating()
        viewModel = PopularViewModel()
        viewModel?.fetchPopularMovies()
//        print("populaaaaaaar \(popularMovies)")
    }
    func setupSubviews() {
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth/3)-10, height: (screenHeight/4)-10)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PopularCollectionViewCell.self)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionView)
        view.addSubview(indicatorView)
        
    }
    func setupStyle() {
        collectionView.backgroundColor = .white
    }
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
//            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
//            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension PopularViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PopularCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let url = "https://image.tmdb.org/t/p/w500"
        guard let poster = popularMovies[indexPath.row].poster_path else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        }
        let urlImage = url+poster
        let imageURL = NSURL(string: urlImage)

        let imagedData = NSData(contentsOf: imageURL! as URL)!

        cell.imageView.image = UIImage(data: imagedData as Data)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let popID = popularMovies[index].id
//        print(popID)
        let vc = MovieDetailViewController()
        vc.movieID = popID
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension PopularViewController: PopularViewModelDelegate {
    
    
    func performOnError(_ error: Error) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            
            let alertController = UIAlertController(title: "Ошибка", message: "Возникла проблема при загрузке данных", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    
    func performOnFetch(movies: [PopularMovie]) {
        DispatchQueue.main.async {
            self.popularMovies = movies
            self.collectionView.reloadData()
            self.indicatorView.stopAnimating()
        }
    }
}

