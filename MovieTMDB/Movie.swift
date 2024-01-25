//
//  Movie.swift
//  MovieTMDB
//
//  Created by Greed on 1/25/24.
//

import Foundation

struct MovieRank: Codable {
    var page: Int
    var results: [Movie]
}

struct Movie: Codable {
    var poster_path: String
    var title: String
    var release_date: String
    var overview: String
    var vote_average: Double
    var genre_ids: [Int]
}

struct Genre {
    var id: Int
    var name: String
    
    static var genreList = [
        Genre(id: 28, name: "Action"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"),
        Genre(id: 99, name: "Documentary"),
        Genre(id: 18, name: "Drama"),
        Genre(id: 10751, name: "Family"),
        Genre(id: 14, name: "Fantasy"),
        Genre(id: 36, name: "History"),
        Genre(id: 27, name: "Horror"),
        Genre(id: 10402, name: "Music"),
        Genre(id: 9648, name: "Mystery"),
        Genre(id: 10749, name: "Romance"),
        Genre(id: 878, name: "Science Fiction"),
        Genre(id: 10770, name: "TV Movie"),
        Genre(id: 53, name: "Thriller"),
        Genre(id: 10752, name: "War"),
        Genre(id: 37, name: "Western")
    ]
    
}
