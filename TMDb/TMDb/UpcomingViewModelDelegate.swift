//
//  UpcomingViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

protocol UpcomingViewModelDelegate: class {
    func performOnFetch(movies: [UpcomingMovie])
    func performOnError( _ error: Error )
}
