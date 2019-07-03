//
//  ImageMovie.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class ImageMovieContainer : Codable {
    let id: Int?
    let posters: [ImageMovie]
}
class ImageMovie: Codable {
    let filePath: String?
    enum CodingKeys: String, CodingKey{
        case filePath = "file_path"
    }
}
