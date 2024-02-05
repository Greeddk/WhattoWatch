//
//  TMDBAPI.swift
//  MovieTMDB
//
//  Created by Greed on 2/4/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case tvTopRatedURL
    case tvTrendURL
    case tvPopularURL
    case tvSeriesDetailURL(id: Int)
    case tvCreditURL(id: Int)
    case tvRecommendURL(id: Int)
    case movieTrendURL
    case movieCreditURL(id: Int)
    case tvLogoURL(id: Int)
    case imageURL(imageURL: String)
    case tvSearchURL(query: String)
    
    var headers: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var paremeter: Parameters {
        switch self {
        case .tvTopRatedURL:
            return ["language": "ko-KR"]
        case .tvTrendURL:
            return ["language": "ko-KR"]
        case .tvPopularURL:
            return [:]
        case .tvSeriesDetailURL:
            return ["language": "ko-KR"]
        case .tvCreditURL:
            return [:]
        case .tvRecommendURL:
            return ["language": "ko-KR"]
        case .movieTrendURL:
            return ["language": "ko-KR"]
        case .movieCreditURL:
            return [:]
        case .tvLogoURL:
            return [:]
        case .imageURL:
            return [:]
        case .tvSearchURL(let query):
            return ["language": "ko-KR", "query": query]
        }
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var endpoint: URL {
        switch self {
        case .tvTopRatedURL:
            return URL(string: baseURL + "/tv/top_rated")!
        case .tvTrendURL:
            return URL(string: baseURL + "/trending/tv/week")!
        case .tvPopularURL:
            return URL(string: baseURL + "/tv/popular")!
        case .tvSeriesDetailURL(let id):
            return URL(string: baseURL + "/tv/\(id)")!
        case .tvCreditURL(let id):
            return URL(string: baseURL + "/tv/\(id)/aggregate_credits")!
        case .tvRecommendURL(let id):
            return URL(string: baseURL + "/tv/\(id)/recommendations")!
        case .movieTrendURL:
            return URL(string: baseURL + "/trending/movie/week")!
        case .movieCreditURL(let id):
            return URL(string: baseURL + "/movie/\(id)/credits")!
        case .tvLogoURL(let id):
            return URL(string: baseURL + "/tv/\(id)/images")!
        case .imageURL(let imageURL):
            return URL(string: "https://image.tmdb.org/t/p/w500" + imageURL)!
        case .tvSearchURL(let query):
            return URL(string: baseURL + "/search/tv?query=\(query)&language=ko-KR")!
        }
    }
}

