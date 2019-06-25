//
//  GenersViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/24/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

protocol GenersViewModelDelegate: class {
    func performOnFetch(genres: [Genre])
    func performOnError(_ error: Error)
}
