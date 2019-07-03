//
//  MovieTableViewCell.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/21/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, ReusableView {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let movieLabel = UILabel()
    func setupSubviews() {
        contentView.addSubview(movieLabel)
    }
    func setupStyle() {
        movieLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        movieLabel.textAlignment = .center
    }
    func setupConstraints() {
        movieLabel.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
            movieLabel.leftAnchor.constraint(equalTo: leftAnchor),
            movieLabel.rightAnchor.constraint(equalTo: rightAnchor),
            movieLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func setLabel(_ genre : Genre) {
        movieLabel.text = genre.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
