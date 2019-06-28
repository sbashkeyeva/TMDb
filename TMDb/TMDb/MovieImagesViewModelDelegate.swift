//
//  MovieImagesViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

protocol  MovieImagesViewModelDelegate: class  {
    func performOnFetch(images: [ImageMovie])
    func performOnError(_ error : Error)
}
