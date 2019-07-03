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
    let posterPath: String?
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
