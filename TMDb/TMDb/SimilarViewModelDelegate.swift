//
//  SimilarViewModelDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
protocol SimilarViewModelDelegate : class{
    func performOnFetch(movies: [SimilarMovie])
    func performOnError(_ error: Error)
}
