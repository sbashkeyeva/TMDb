//
//  PopularMovie.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/25/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation



class MovieContainer:Codable {
    let results:[PopularMovie]
   
}
class PopularMovie:Codable {
    let id: Int
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        
    }
    
}
