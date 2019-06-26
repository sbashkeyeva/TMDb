//
//  PopularCollectionViewCell.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/25/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell, ReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupSubviews()
        setupConstraints()
//        setupStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView = UIImageView()
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func setImage(_ popular: PopularMovie) {
        
    }
    func setupStyle() {
        let image:UIImage = UIImage(named:"flower")!
        imageView.image = image
        
    }
    func setupSubviews() {
        contentView.addSubview(imageView)
    }
}
