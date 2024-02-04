//
//  TMDBAPIManager.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static var id: Int = 0
    
    func request<T:Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T) -> Void ) {
        
        AF.request(api.endpoint, method: api.method, parameters: api.paremeter, encoding: URLEncoding(destination: .queryString), headers: api.headers).responseDecodable(of: type) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(T.self,"통신오류",failure)
            }
        }
    }
    
}
