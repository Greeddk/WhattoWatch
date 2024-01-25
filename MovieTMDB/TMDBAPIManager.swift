//
//  TMDBAPIManager.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    enum APICase {
        case trendURL
        case getImageURL
        case creditURL
    }
    
    static let trendURL = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.TMDB.rawValue)"
    
    static var creditURL = "https://api.themoviedb.org/3/movie/{movie_id}/credits"
    
    func callRequest(url: URL, completionHandler: @escaping ([Movie]) -> Void) {
        
        AF.request(url).responseDecodable(of: MovieRank.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
                
            case .failure(let failure):
                print("통신 오류")
            }
        }
    }
    
    
}
