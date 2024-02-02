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
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static var id: Int = 0
    
    enum APICase {
        static let topRatedTVURL = "/tv/top_rated?language=ko-KR"
        static let trendTVURL = "/trending/tv/week?language=ko-KR"
        static let popularTVURL = "/tv/popular"
        static var seriesDetailURL = "/tv/\(id)?language=ko-KR"
        static var creditTVURL = "/tv/\(id)/aggregate_credits"
        static var recommendTVURL = "/tv/\(id)/recommendations?language=ko-KR"
        static let trendMovieURL = "/trending/movie/week?language=ko-KR"
        static var creditMovieURL = "/movie/\(id)/credits"
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
    
    func tvShowLogoCallRequest(url: String, completionHandler: @escaping (ShowImage) -> Void) {
        
        guard let url = URL(string: baseURL + url) else { return }
        
        AF.request(url, headers: header).responseDecodable(of: ShowImage.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
                
            case .failure(let failure):
                print("통신 오류", failure)
            }
        }
    }
    
    func tvSeriesDetailCallRequest(url: String, completionHandler: @escaping (TVSeriesInfo) -> Void ) {
        
        guard let url = URL(string: baseURL + url) else { return }
        
        AF.request(url, headers: header).responseDecodable(of: TVSeriesInfo.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func castingCallRequest(url: String, completionHandler: @escaping (CastingInfo) -> Void ) {
        
        guard let url = URL(string: baseURL + url) else { return }
        
        AF.request(url, headers: header).responseDecodable(of: CastingInfo.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
