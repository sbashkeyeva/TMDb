//
//  Genres.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/24/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class GenresContainer: Codable {
    let genres: [Genre]
}
class Genre:Codable {
    let id: Int
    let name: String
}
