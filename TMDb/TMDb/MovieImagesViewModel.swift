//
//  MovieImagesViewModel.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/27/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

class MovieImagesViewModel : MovieImagesViewModelProtocol {
    var delegate: MovieImagesViewModelDelegate?
    
    func fetchMovieImages(by id: Int) {
        var imageMovies = [ImageMovie]()
        var posterPath = [String]()
        let imageMoviesRequestData = ImageMoviesRequestData(parameters: [:], movieId: id)
        let networkAdapter = NetworkAdapter(session: session)
        _ = networkAdapter.perform(request: imageMoviesRequestData.urlRequest) { [weak self] result in
            print("wtff")
            switch result {
            case .success(let object):
                print("success")
                print("deatail movie object",object)
                let movies: ImageMovieContainer = convert(object: object)
                print(movies)
                for i in movies.posters {
                    imageMovies.append(i)
//                    print(i.file_path)
                    posterPath.append(i.file_path!)
                    
                }
                print(posterPath)
                self?.delegate?.performOnFetch(images: imageMovies)
            case .failure(let error):
                print("failure")
                self?.delegate?.performOnError(error)
            }
        }
    }
    
    
}
