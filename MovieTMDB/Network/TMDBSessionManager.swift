//
//  TMDBSessionManager.swift
//  MovieTMDB
//
//  Created by Greed on 2/5/24.
//

import Foundation

enum APIError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TMDBSessionManager {
    
    static let shared = TMDBSessionManager()
    
    func fetchSearchData(query: String, completionHandler: @escaping (([TVShow]?, APIError?) -> Void)) {
        
        var url = URLRequest(url: TMDBAPI.tvSearchURL(query: query).endpoint)
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("통신 O, data 안옴")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("통신 O, 응답값이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("statusCode에 이상이 있음")
                    completionHandler(nil, .invalidData)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TVData.self, from: data)
                    dump(result)
                    completionHandler(result.results, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
            
            
        }.resume()
        
        
        
    }
    
}
