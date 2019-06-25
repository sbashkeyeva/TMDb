//
//  GenersViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/24/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

protocol GenersViewModelProtocol: class {
    var delegate: GenersViewModelDelegate? { get set }
    func fetchGenres()
}
