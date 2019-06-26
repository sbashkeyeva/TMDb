//
//  MovieDetailViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
protocol MovieDetailViewModelDelegate: class {
    func performOnFetch(movie: [MovieDetail])
    func performOnError( _ error: Error )
}
