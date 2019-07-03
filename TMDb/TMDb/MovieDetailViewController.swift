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
//    var scrollView = UIScrollView(frame: CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//    let scrollContentView = UIView()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    let indicatorView = UIActivityIndicatorView(style: .gray)
    var numberThatINeed: Int = 0
    let otherView = UIView()
    let contentView = UIView()
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel = MovieDetailViewModel()
        
        if let id = movieID {
            indicatorView.startAnimating()
            viewModel?.fetchMovieDetail(by: id)
            self.numberThatINeed = id
        }
        
        
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
        otherView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        seeButton.translatesAutoresizingMaskIntoConstraints = false
        similarLabel.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
//            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            otherView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            otherView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            otherView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            otherView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overviewLabel.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 20),
//            overviewLabel.heightAnchor.constraint(equalToConstant: 180),
//            overviewLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            overviewLabel.widthAnchor.constraint(equalToConstant: 400),
            overviewLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            seeButton.widthAnchor.constraint(equalToConstant: 400),
            seeButton.heightAnchor.constraint(equalToConstant: 100),
            seeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            seeButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            similarLabel.topAnchor.constraint(equalTo: seeButton.bottomAnchor, constant: 20),
            similarLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            similarLabel.widthAnchor.constraint(equalToConstant: 200),
            collectionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            collectionView.topAnchor.constraint(equalTo: similarLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSubviews() {
        view.addSubview(otherView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SimilarMoviesCollectionViewCell.self)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        contentView.addSubview(label)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(similarLabel)
        contentView.addSubview(seeButton)
        contentView.addSubview(collectionView)
        view.addSubview(indicatorView)
    }
    
    func setupStyle() {
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = view.bounds
        layout.itemSize  = CGSize(width: 120, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        overviewLabel.numberOfLines = 0
        overviewLabel.backgroundColor = .clear
        overviewLabel.font = UIFont.systemFont(ofSize: 20)
        overviewLabel.textAlignment = .justified
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 30)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        similarLabel.text = "Similar movies:"
        similarLabel.font = UIFont.systemFont(ofSize: 25)
        seeButton.setTitle("SEE IMAGES", for: .normal)
        seeButton.backgroundColor = .clear
        seeButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        seeButton.setTitleColor(.black, for: .normal)
        seeButton.layer.borderWidth = 1
        seeButton.layer.borderColor = UIColor.black.cgColor
        seeButton.layer.cornerRadius = 5
        seeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        collectionView.backgroundColor = .clear
    }
    @objc func buttonAction(sender: UIButton) {
        print("Button tapped")
        let vc = MovieImagesViewController()
        vc.movieID = numberThatINeed
        navigationController?.pushViewController(vc, animated: true)
       
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.width, height: contentView.frame.height)
//    }

}
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func performOnFetch(movie: [MovieDetail]) {
        DispatchQueue.main.async {
            
            self.movie = movie
            self.label.text = movie[0].title
            self.overviewLabel.text = "Overview: "+(movie[0].overview ?? "kjg")
            self.poster = movie[0].posterPath!
            let str = "https://image.tmdb.org/t/p/w500"
            let imgUrl = str+self.poster
            let imageUrl = NSURL(string: imgUrl)
            let imagedata = NSData(contentsOf: imageUrl as! URL)
            self.imageView.image = UIImage(data: imagedata as! Data)
            self.otherView.backgroundColor = UIColor(patternImage: UIImage(data: imagedata! as Data)!.alpha(0.1))
            self.indicatorView.stopAnimating()
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.width, height: self.contentView.frame.height)
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


extension MovieDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SimilarMoviesCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        guard let poster = similarMovies[indexPath.row].posterPath else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        }
        let str = "https://image.tmdb.org/t/p/w500"
        let urlImage = str+poster
        let imageUrl = NSURL(string: urlImage )
        let imageData = NSData(contentsOf: imageUrl! as URL)
        cell.imageView.image = UIImage(data: imageData! as Data)
        return cell
    }
    
}
extension MovieDetailViewController : SimilarViewModelDelegate {
    
    func performOnFetch(movies: [SimilarMovie]) {
        DispatchQueue.main.async {
            self.similarMovies = movies
            self.collectionView.reloadData()
            self.indicatorView.stopAnimating()
        }
    }
    
    
}

extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

