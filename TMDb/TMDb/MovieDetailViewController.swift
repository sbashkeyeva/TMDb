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
    var viewModelSimilar : SimilarViewModelProtocol? {
        didSet { viewModelSimilar?.delegate = self }
    }
    var movieID : Int?
    let str = "567"
    var simID : Int?
    weak var delegate: MovieDelegate?
    let label = UILabel()
    let overviewLabel = UILabel()
    let similarLabel  = UILabel()
    let imageView = UIImageView()
    let seeButton = UIButton()
    var movie = [MovieDetail]()
    var similarMovies = [SimilarMovie]()
    let string : String = "https://image.tmdb.org/t/p/w500"
    var poster = ""
    let scrollView = UIScrollView()
    let scrollContentView = UIView()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let indicatorView = UIActivityIndicatorView(style: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel = MovieDetailViewModel()
        
        if let id = movieID {
            indicatorView.startAnimating()
            viewModel?.fetchMovieDetail(by: id)
        }
        print("movie id is fetched", movieID)
        
        viewModelSimilar = SimilarViewModel()
        if let simId = movieID {
            indicatorView.startAnimating()
            viewModelSimilar?.fetchSimilarMovies(by: simId)
        }
        
        delegate?.sendString(str)
        setupSubviews()
        setupConstraints()
        setupStyle()
        
    }

    func setupConstraints() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        seeButton.translatesAutoresizingMaskIntoConstraints = false
        similarLabel.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overviewLabel.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 20),
            overviewLabel.heightAnchor.constraint(equalToConstant: 180),
            overviewLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            seeButton.widthAnchor.constraint(equalToConstant: 200),
            seeButton.heightAnchor.constraint(equalToConstant: 100),
            seeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            seeButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor),
            similarLabel.topAnchor.constraint(equalTo: seeButton.bottomAnchor, constant: 20),
            similarLabel.widthAnchor.constraint(equalToConstant: 200),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            collectionView.topAnchor.constraint(equalTo: similarLabel.bottomAnchor, constant: 10),
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSubviews() {
        view.addSubview(scrollView)
        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SimilarMoviesCollectionViewCell.self)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        scrollView.addSubview(label)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(similarLabel)
        scrollView.addSubview(seeButton)
        scrollView.addSubview(collectionView)
        view.addSubview(indicatorView)
    }
    
    func setupStyle() {
        layout.itemSize  = CGSize(width: 100, height: 200)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal 
        collectionView.backgroundColor = .white
        overviewLabel.numberOfLines = 0
        overviewLabel.backgroundColor = .green
        label.backgroundColor = .red
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        similarLabel.text = "Similar movies:"
        seeButton.setTitle("SEE IMAGES", for: .normal)
        seeButton.backgroundColor = .red
        seeButton.titleLabel?.textColor = .black
        seeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 25)
        seeButton.layer.borderWidth = 1
        seeButton.layer.borderColor = UIColor.black.cgColor
        seeButton.layer.cornerRadius = 5
    }

}
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func performOnFetch(movie: [MovieDetail]) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.movie = movie
            print("dispatch",movie)
            self.label.text = movie[0].title
            self.overviewLabel.text = movie[0].overview
            self.poster = movie[0].poster_path!
            let str = "https://image.tmdb.org/t/p/w500"
            let imgUrl = str+self.poster
            let imageUrl = NSURL(string: imgUrl)
            let imagedata = NSData(contentsOf: imageUrl as! URL)
            self.imageView.image = UIImage(data: imagedata as! Data)
//            print(self.poster)
            
        }
    }
    
    
    func performOnError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка", message: "Возникла проблема при загрузке данных", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
            self.indicatorView.stopAnimating()
        }
    }
}
let names = ["sds","sdsd","sdsd"]
extension MovieDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SimilarMoviesCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        guard let poster = similarMovies[indexPath.row].poster_path else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        }
        let str = "https://image.tmdb.org/t/p/w500"
        var urlImage = str+poster
        let imageUrl = NSURL(string: urlImage )
        let imageData = NSData(contentsOf: imageUrl as! URL)
        cell.imageView.image = UIImage(data: imageData as! Data)
        return cell
    }
    
    
}
extension MovieDetailViewController : SimilarViewModelDelegate {
    func performOnFetch(movies: [SimilarMovie]) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.similarMovies = movies
            self.collectionView.reloadData()
        }
    }
    
    
}

