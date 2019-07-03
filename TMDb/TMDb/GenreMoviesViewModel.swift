//
//  GenreMoviesViewModel.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/28/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class GenreMoviesViewModel: GenreMoviesViewModelProtocol {
    weak var delegate: GenreMoviesViewModelDelegate?
    
    func fetchGenreMovies(by id: Int) {
        var genreMovies = [GenreMovie]()
        let genreMoviesRequestData = GenreMoviesRequestData(genreID: id, parameters: ["with_genres":String(id)])
        let networkAdapter = NetworkAdapter(session: session)
        _ = networkAdapter.perform(request: genreMoviesRequestData.urlRequest) { [weak self] result in
            switch result {
            case .success(let object):
                let list: GenreMovieContainer = convert(object: object)
                for item in list.results {
                    genreMovies.append(item)
                }
                self?.delegate?.performOnFetch(genreMovies: genreMovies)
            case .failure(let error):
                self?.delegate?.performOnError(error)
            }
        }
    }
}
