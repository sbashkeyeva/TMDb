//
//  GenreMovies.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/28/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class GenreMovieContainer: Codable {
    let results: [GenreMovie]
}

class GenreMovie: Codable {
    let posterPath : String?
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
    
}
