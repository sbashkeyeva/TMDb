//
//  PopularViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/25/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

protocol PopularViewModelDelegate: class {
    func performOnFetch(movies: [PopularMovie])
    func performOnError(_ error: Error)
}


