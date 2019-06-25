//
//  GenresViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/21/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit


class GenresViewController: UIViewController {
    
    var viewModel: GenersViewModelProtocol? {
        didSet { viewModel?.delegate = self }
    }
    
    let tableView = UITableView()
    var genres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        addSubviews()
        addConstraints()
        
        viewModel?.fetchGenres()
    }
    
    func addSubviews(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self)
        view.addSubview(tableView)
    }
    
    func addConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension GenresViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.movieLabel.textAlignment = .center
        let genre = genres[indexPath.row]
        cell.setLabel(genre)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
        
}

extension GenresViewController: GenersViewModelDelegate {
    
    func performOnError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка", message: "Возникла проблема при загрузке данных", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    
    func performOnFetch(genres: [Genre]) {
        DispatchQueue.main.async {
            self.genres = genres
            self.tableView.reloadData()
        }
    }
}
