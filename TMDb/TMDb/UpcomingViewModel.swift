//
//  UpcomingViewModel.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/26/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation
class UpcomingViewModel: UpcomingViewModelProtocol {
    var delegate: UpcomingViewModelDelegate?
    
    func fetchUpcomingMovies() {
        
        var upcomingMovies = [UpcomingMovie]()
        let upcomingMoviesRequestData = UpcomingMoviesRequestData(parameters: [:])
        let networkAdapter = NetworkAdapter(session: session)
        _ = networkAdapter.perform(request: upcomingMoviesRequestData.urlRequest) { [weak self] result in
            switch result {
            case .success(let object):
                print("success")
                let list: UpcomingContainer = convert(object: object)
                print("list \(list)")
                for i in list.results {
                    upcomingMovies.append(i)
                    print(i)
                }
                
                self?.delegate?.performOnFetch(movies: upcomingMovies)
            case .failure(let error):
                print("failure")
                self?.delegate?.performOnError(error)
            }
        }
    }
    

}
