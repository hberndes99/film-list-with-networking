//
//  NetworkingManager.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import Foundation
import Alamofire

class NetworkingManager {
    
    
    static func getFilmsByTitle(title: String, completion: @escaping ([Film]) -> Void) {
        let title = title
        let formattedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let formattedTitle = formattedTitle {
            let endpoint = "https://api.themoviedb.org/3/search/movie?api_key=3b14d1d83547bd238e300f427b8dbc13&language=en-US&query=\(formattedTitle)&page=1&include_adult=false"
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

    /*
     
     // can't get this endpoint to work
    static func getFilmsByGenre(genre: String, completion: @escaping ([Film]) -> Void) {
        let genre = genre
        var apiKey = "3b14d1d83547bd238e300f427b8dbc13"
        let endpoint = "https://api.themoviedb.org/3/search/movie?api_key=3b14d1d83547bd238e300f427b8dbc13&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=thriller"
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
 */
    
    
}
