//
//  SimilarViewModel.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class SimilarViewModel: SimilarViewModelProtocol {
    var delegate: SimilarViewModelDelegate?
    func fetchSimilarMovies(by id: Int) {
        var similarMovies = [SimilarMovie]()
        let similarMoviesRequestData = SimilarMoviesRequestData(movieId: id, parameters: [:])
        let networkAdapter = NetworkAdapter(session: session)
        _ = networkAdapter.perform(request: similarMoviesRequestData.urlRequest) { [weak self] result in
            switch result {
            case .success(let object):
                print("success")
                print("deatail movie object",object)
                let movies: SimilarContainer = convert(object: object)
                for i in movies.results{
                     similarMovies.append(i)
                    print(i.poster_path)
                }
                self?.delegate?.performOnFetch(movies: similarMovies)
            case .failure(let error):
                print("failure")
                self?.delegate?.performOnError(error)
            }
        }
    }
    
    
}
