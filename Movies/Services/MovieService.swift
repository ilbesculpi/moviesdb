//
//  MovieService.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import Foundation
import Combine

enum MovieListType {
    case popular
    case topRated
}

struct FetchMoviesResponse: Decodable {
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}

protocol MovieService {
    
    func fetchMovies(_ sort: MovieListType, page: Int) -> AnyPublisher<FetchMoviesResponse, Error>
    
}
