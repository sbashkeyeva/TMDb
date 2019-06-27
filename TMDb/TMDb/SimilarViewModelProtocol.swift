//
//  SimilarViewModelProtocol.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
protocol SimilarViewModelProtocol: class{
    var delegate: SimilarViewModelDelegate? { get set }
    func fetchSimilarMovies(by id: Int)
}
