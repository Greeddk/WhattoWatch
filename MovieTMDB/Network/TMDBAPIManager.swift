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
    let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
    let baseURL = "https://api.themoviedb.org/3"
    
    enum APICase {
        static let topRatedTVURL = "/tv/top_rated?language=ko-KR"
        static let trendTVURL = "/trending/tv/week?language=ko-KR"
        static let popularTVURL = "/tv/popular"
        
        static let trendMovieURL = "/trending/movie/week?language=ko-KR"
        static var creditURL = "/movie/{movie_id}/credits"
    }
    
    func movieCallRequest(url: String, completionHandler: @escaping ([Movie]) -> Void) {
        
        guard let url = URL(string: baseURL + url) else { return }
        
        AF.request(url, headers: header).responseDecodable(of: MovieRank.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
                
            case .failure(let failure):
                print("통신 오류", failure)
            }
        }
    }
    
    func tvShowCallRequest(url: String, completionHandler: @escaping ([TVShow]) -> Void) {
        
        guard let url = URL(string: baseURL + url) else { return }
        
        AF.request(url, headers: header).responseDecodable(of: TVRank.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
                
            case .failure(let failure):
                print("통신 오류", failure)
            }
        }
    }
    
    
}
