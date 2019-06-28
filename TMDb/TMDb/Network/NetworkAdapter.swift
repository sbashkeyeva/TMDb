//
//  NetworkAdapter.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/24/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import Foundation

enum HTTPRequestType: String { case POST, PUT, GET }

protocol  NetworkService {
}

protocol RequestDataProtocol {
    var endpoint: String { get }
    var httpMethod: HTTPRequestType { get }
    var parameters: [String: String] { get set }
}

extension RequestDataProtocol {
    
    var baseUrl: String { return "https://api.themoviedb.org/3" }
    
    var url: String {
        var newParameters = parameters
        newParameters["api_key"] = "02da584cad2ae31b564d940582770598"
//        newParameters["language"] = "en-US"
        let queryParameters = newParameters.map { $0 + "=" + $1 }.joined(separator: "&")
        return baseUrl + endpoint + "?" + queryParameters
    }
    var parameters: [String : String] { return [:] }
    
    var urlRequest: URLRequest {
        guard let url = URL(string: url) else { fatalError("url is not relevant") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}
struct PopularMoviesRequestData: RequestDataProtocol {
    let endpoint = "/movie/popular"
    var httpMethod: HTTPRequestType { return .GET }
    var parameters: [String : String] = [:]
}

struct MovieRequestData: RequestDataProtocol {
    var endpoint: String { return "/movie/" + String(movieId) }
    var httpMethod: HTTPRequestType { return .GET }
    let movieId: Int
    var parameters: [String : String]
}
struct UpcomingMoviesRequestData: RequestDataProtocol {
    var parameters: [String : String]
    
    var httpMethod: HTTPRequestType { return .GET }
    
    var endpoint: String { return "/movie/upcoming" }
}

struct SimilarMoviesRequestData: RequestDataProtocol {
    var endpoint: String { return "/movie/"+String(movieId)+"/similar" }
    let movieId : Int
    var httpMethod: HTTPRequestType { return .GET }
    var parameters: [String:String]
}

struct GenresRequestData: RequestDataProtocol {
    var endpoint: String { return "/genre/movie/list" }
    
    var httpMethod: HTTPRequestType { return .GET }
    
    var parameters: [String : String]
}

struct ImageMoviesRequestData: RequestDataProtocol {
    var parameters: [String : String]
    let movieId: Int
    var endpoint: String { return "/movie/"+String(movieId)+"/images" }
    var httpMethod: HTTPRequestType { return .GET }
}

var session: URLSession = {
    let configuration = URLSessionConfiguration.default
    return URLSession(configuration: configuration)
}()

enum Result {
    case success(object: Any)
    case failure(error: Error)
}

class NetworkAdapter: NetworkService {
    
    let urlSession : URLSession
    init(session: URLSession) {
        urlSession = session
    }
    
    func perform(requestData: RequestDataProtocol, completion: @escaping (_ result: Result) -> Void) {
        perform(request: requestData.urlRequest, completion: completion)
    }

    func perform(request:URLRequest, completion: @escaping (_ result: Result)->Void){
        session.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError?{
                let result = Result.failure(error: error)
                completion(result)
            }
            guard let data = data else { return }
            let result = Result.success(object: data)
            completion(result)
            guard let response = response as? HTTPURLResponse, 200...299~=response.statusCode else{
                print("Response is nill or status code out of range")
                return
            }
            }
            .resume()
    }
    
}

//let genresRequestData = GenresRequestData(parameters: [:])
//var networkAdapter = NetworkAdapter(session: session)
//var xx = networkAdapter.perform(request: genresRequestData.urlRequest) { (result) in
//    switch result {
//    case .success(let object):
//        print("success")
//        if let data = object as? Data{
//            let obj = String(data: data, encoding: .utf8)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//            print(obj)
//        }
//    case .failure(let error ):
//        print("error")
//    }
//    
//}


