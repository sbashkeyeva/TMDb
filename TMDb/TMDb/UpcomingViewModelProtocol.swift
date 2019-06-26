//
//  UpcomingViewModelProtocol.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

protocol UpcomingViewModelProtocol: class {
    var delegate: UpcomingViewModelDelegate? { get set }
    func fetchUpcomingMovies()
}
