//
//  GenreMoviesViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/28/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

protocol GenreMoviesViewModelDelegate : class {
    func performOnFetch(genreMovies: [GenreMovie])
    func performOnError(_ error: Error)
}
