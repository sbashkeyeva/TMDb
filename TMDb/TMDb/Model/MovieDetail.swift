//
//  MovieDetail.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
class MovieDetail: Codable {
    let posterPath: String?
    let overview: String?
    let title: String?
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case title
    }
}
