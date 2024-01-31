//
//  TVShow.swift
//  MovieTMDB
//
//  Created by Greed on 1/30/24.
//

import Foundation

struct TVRank: Decodable {
    let page: Int
    let results: [TVShow]
}

struct TVShow: Decodable {
    let id: Int
    let name: String
    let poster_path: String?
}

struct ShowImage: Decodable {
    let id: Int
    let logos: [ShowLogo]
}

struct ShowLogo: Decodable {
    let logo: String
    
    enum CodingKeys: String, CodingKey {
        case logo = "file_path"
    }
}
