//
//  GenreMoviesViewModelProtocol.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/28/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

protocol GenreMoviesViewModelProtocol: class  {
    var delegate: GenreMoviesViewModelDelegate? { get set }
    func fetchGenreMovies(by id: Int)
}
