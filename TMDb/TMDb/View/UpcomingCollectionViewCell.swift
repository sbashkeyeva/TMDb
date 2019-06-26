//
//  UpcomingCollectionViewCell.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell, ReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView = UIImageView()
    func setupSubviews() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupStyle() {
        backgroundColor = .green
    }
}