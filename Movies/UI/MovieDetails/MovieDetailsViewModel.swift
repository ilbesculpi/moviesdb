//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import Foundation

class MovieDetailsViewModel: MovieDetailsViewModelContract {
    
    weak var view: MovieDetailsViewContract!
    var movie: Movie!
    
    func setMovie(_ movie: Movie) {
        self.movie = movie
    }
    
    func fetchMovie() {
        var props = MovieDetailsProps()
        props.title = movie.title
        props.overview = movie.overview
        view.displayMovieDetails(props)
    }
    
}
