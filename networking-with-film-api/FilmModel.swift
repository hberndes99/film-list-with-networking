//
//  FilmModel.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import Foundation

struct FilmList: Codable {
    var results: [Film]
}

struct Film: Codable, Equatable {
    var title: String
    var id: Int
    var overview: String
    var voteAverage: Double
    var posterPath: String?
    /*
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case overview
        case rating = "vote_average"
        case imageUrl = "poster_path"
    }
 */
}
