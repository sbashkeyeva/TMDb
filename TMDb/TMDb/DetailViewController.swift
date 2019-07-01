//
//  DetailViewController.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/28/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupStyle()
    }
    
    let imageView = UIImageView()
    let movieLabel = UILabel()
    let overviewLabel = UILabel()
    let seeButton = UIButton()
    let scrollView = UIScrollView()
    
    func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(movieLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(seeButton)
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        movieLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        seeButton.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += [
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupStyle() {
        
    }
    

}
