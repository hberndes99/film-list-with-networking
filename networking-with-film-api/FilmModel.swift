//
//  FilmModel.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import Foundation

struct FilmList {
    var results: [Film]
}

struct Film {
    var title: String
    var id: Int
    var overview: String
    var vote_average: Double
}