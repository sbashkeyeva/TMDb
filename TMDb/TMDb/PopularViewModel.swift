//
//  PopularViewModel.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/25/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
import  UIKit
class PopularViewModel: PopularViewModelProtocol {
    
    
    weak var delegate: PopularViewModelDelegate?
    
    func fetchPopularMovies() {
        var popularMovies = [PopularMovie]()
        let popularMoviesRequestData = PopularMoviesRequestData(parameters: [:])
        let networkAdapter = NetworkAdapter(session: session)
        _ = networkAdapter.perform(request: popularMoviesRequestData.urlRequest) { [weak self] result in
            switch result {
            case .success(let object):
                print("success")
                let list: MovieContainer = convert(object: object)
                print("list \(list)")
                for i in list.results {
                    popularMovies.append(i)
                    print(i.poster_path)
                     print(i)
                }
               
                self?.delegate?.performOnFetch(movies: popularMovies )
            case .failure(let error):
                print("failure")
                self?.delegate?.performOnError(error)
            }
        }
    }
}

