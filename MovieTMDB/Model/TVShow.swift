//
//  TVShow.swift
//  MovieTMDB
//
//  Created by Greed on 1/30/24.
//

import Foundation

struct TVData: Decodable {
    let page: Int
    let results: [TVShow]
}

struct TVShow: Decodable {
    let id: Int
    let backdrop_path: String?
    let poster_path: String?
    let name: String
    let first_air_date: String
    let original_name: String
    let overview: String?
    let vote_average: Double
//    let genres: [Genre]
}


struct ShowImage: Decodable {
    let id: Int
    let logos: [ShowLogo]
}

struct ShowLogo: Decodable {
    let logo: String?
    
    enum CodingKeys: String, CodingKey {
        case logo = "file_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.logo = try container.decodeIfPresent(String.self, forKey: .logo) ?? ""
    }
}

struct TVSeriesInfo: Decodable {
    let backdrop_path: String?
    let poster_path: String
    let name: String
    let original_name: String
    let overview: String?
    let first_air_date: String
    let last_air_date: String
    let vote_average: Double
    let genres: [Genre]
    let number_of_episodes: Int
    let number_of_seasons: Int
    
    var airDate: String {
        return first_air_date + " ~ " + last_air_date
    }
}

struct CastingInfo: Decodable {
    let cast: [Actor]
}

struct Actor: Decodable {
    let name: String
    let profile_path: String?
    let roles: [Role]
}

struct Role: Decodable {
    let character: String
}
