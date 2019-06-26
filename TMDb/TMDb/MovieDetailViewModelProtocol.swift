//
//  MovieDetailViewModelProtocol.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
protocol MovieDetailViewModelProtocol: class {
    var delegate: MovieDetailViewModelDelegate? { get set }
    func fetchMovieDetail(by id: Int)
}
