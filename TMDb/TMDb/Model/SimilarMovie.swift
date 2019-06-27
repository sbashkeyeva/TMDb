//
//  SimilarMovie.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class SimilarContainer: Codable {
    let results: [SimilarMovie]
}

class SimilarMovie: Codable {
    let poster_path: String?
}
