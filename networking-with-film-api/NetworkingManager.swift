//
//  NetworkingManager.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import Foundation
import Alamofire

class NetworkingManager {
    
    static func getFilmsByTitleAlamofire(title: String, completion: @escaping ([Film]) -> Void) {
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
    
    static func getFilmsByTitle(title: String, completion: @escaping ([Film]) -> Void) {
        
        let title = title
        let formattedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let formattedTitle = formattedTitle {
            // will force unwrapping crash the app
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=3b14d1d83547bd238e300f427b8dbc13&language=en-US&query=\(formattedTitle)&page=1&include_adult=false")!
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error occured need to deal with this")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print(" response isn't a http response obj or code isn't good")
                    return
                }
                guard let mime = httpResponse.mimeType, mime == ("application/json") else {
                    print("response isn't json as expected")
                    return
                }
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let filmData = try? jsonDecoder.decode(FilmList.self, from: data) {
                        completion(filmData.results)
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
