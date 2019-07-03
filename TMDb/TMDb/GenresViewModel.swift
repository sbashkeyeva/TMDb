//
//  GenresViewModel.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/24/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

func convert<T: Codable>(object: Data) -> T {
    if let data = object as? Data {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            print(json)
        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
        
    }
    guard let codableObject = try? JSONDecoder().decode(T.self, from: object) else {
        fatalError("Error: Couldn't decode data into Blog")
    }
    print("codable object", codableObject)
    return codableObject
}

class GenresViewModel: GenersViewModelProtocol {
    
    weak var delegate: GenersViewModelDelegate?
    
    func fetchGenres() {
        var genres = [Genre]()
        let genresRequestData = GenresRequestData(parameters: [:])
        let networkAdapter = NetworkAdapter(session: session)
        _ = networkAdapter.perform(request: genresRequestData.urlRequest) { [weak self] result in
            switch result {
            case .success(let object):
                let list: GenresContainer = convert(object: object)
                
                for item in list.genres {
//                    print(i.name)
                    genres.append(item)
                }
                self?.delegate?.performOnFetch(genres: genres)
            case .failure(let error):
                self?.delegate?.performOnError(error)
            }
        }
    }
}
