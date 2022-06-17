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
    case recent
}

protocol MovieService {
    
    func fetchMovies(_ sort: MovieListType) -> AnyPublisher<[Movie], Error>
    
}
