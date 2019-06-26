//
//  MovieDetailViewModel.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate?
    
    func fetchMovieDetail(by id: Int) {
        
        var movieDetail = [MovieDetail]()
        let movieDetailRequestData = MovieRequestData(movieId: id, parameters: [:])
        let networkAdapter = NetworkAdapter(session: session)
        _ = networkAdapter.perform(request: movieDetailRequestData.urlRequest) { [weak self] result in
            switch result {
            case .success(let object):
                print("success")
                self?.delegate?.performOnFetch(movie: movieDetail)
            case .failure(let error):
                print("failure")
                self?.delegate?.performOnError(error)
            }
        }
}

}
