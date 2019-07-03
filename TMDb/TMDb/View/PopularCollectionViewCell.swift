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
        setupSubviews()
        setupConstraints()
        setupStyle()
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
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
    }
    func setupSubviews() {
        contentView.addSubview(imageView)
    }
}
