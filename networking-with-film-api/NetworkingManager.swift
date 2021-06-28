//
//  NetworkingManager.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import Foundation
import Alamofire

class NetworkingManager {
    
    private var apiKey = "3b14d1d83547bd238e300f427b8dbc13"
    
    static func getFilmsByGenre(completion: @escaping ([Film]) -> Void) {
        let endpoint = "https://api.themoviedb.org/3/search/movie?api_key=3b14d1d83547bd238e300f427b8dbc13&language=en-US&query=harry%20potter&page=1&include_adult=false"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let filmsResponse = try? jsonDecoder.decode(FilmList.self, from: data) {
                    completion(filmsResponse.results)
                }
            case.failure:
                print("failed")
            }
        }
    }
}
