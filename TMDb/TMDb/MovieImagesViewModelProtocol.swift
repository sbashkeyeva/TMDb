//
//  MovieImagesViewModelProtocol.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
protocol MovieImagesViewModelProtocol: class {
    var delegate: MovieImagesViewModelDelegate? {get set}
    func fetchMovieImages(by id: Int)
}
