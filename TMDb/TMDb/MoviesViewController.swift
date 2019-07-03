//
//  MoviesViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/21/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

class MoviesViewController: UIViewController {
    let tableView = UITableView()
    var names = ["Popular", "Upcoming"]
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
    }
    func addSubviews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self)
        view.addSubview(tableView)
    }
    func addConstraints() {
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
extension MoviesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.movieLabel.textAlignment = .center
        cell.movieLabel.text = names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        let destination = PopularViewController()
        switch index {
        case 0:
            let destination = PopularViewController()
            navigationController?.pushViewController(destination, animated: true)
        case 1:
            let destination = UpcomingViewController()
            navigationController?.pushViewController(destination, animated: true)
        default:
            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
}
