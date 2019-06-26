//
//  PopularViewModelProtocol.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/25/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//



protocol PopularViewModelProtocol: class {
    var delegate: PopularViewModelDelegate? { get set }
    func fetchPopularMovies()
}
