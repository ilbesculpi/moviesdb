//
//  MovieListServiceImpl.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import Foundation
import Combine



let tags = [
    MovieListType.popular: "popular",
    MovieListType.topRated: "top_rated"
]

class MovieServiceImpl: MovieService {
    
    func fetchMovies(_ sort: MovieListType, page: Int = 1) -> AnyPublisher<FetchMoviesResponse, Error> {
        
        // Build Request
        let apiKey = "34738023d27013e6d1b995443764da44"
        let tag = tags[sort]!
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(tag)?api_key=\(apiKey)&page=\(page)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Fetch from network and decode
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: FetchMoviesResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
