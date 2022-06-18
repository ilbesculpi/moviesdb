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
        var item = MovieDetailsProps()
        item.title = movie.title
        item.overview = movie.overview
        // release date
        if let releaseDate = movie.releaseDateObj {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"
            item.releaseDate = formatter.string(from: releaseDate)
        }
        item.posterImageUrl = URL(string: movie.posterUrl)
        item.backdropImageUrl = URL(string: movie.backdropUrl)
        view.displayMovieDetails(item)
        view.displayTitle(movie.title)
    }
    
}
