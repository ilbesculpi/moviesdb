//
//  MovieListServiceImpl.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import Foundation
import Combine

class MovieServiceImpl: MovieService {
    
    func fetchMovies(_ sort: MovieListType) -> AnyPublisher<[Movie], Error> {
        
        // Build Request
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Fetch from network and decode
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Movie].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
