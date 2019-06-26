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
    let page: Int
}
class PopularMovie:Codable {
    let id: Int
//    let originalLanguage: String?
//    let originalTitle: String?
    let poster_path: String?
//    enum CodinKeys:String,CodingKey {
//        case posterPath = "poster_path"
////        case originalLanguage = "original_language"
////        case originalTitle = "original_title"
//    }
}
