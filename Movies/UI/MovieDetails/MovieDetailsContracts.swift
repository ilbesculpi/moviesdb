//
//  MovieDetailsContracts.swift
//  Movies
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import Foundation

struct MovieDetailsProps {
    
    var title: String = ""
    var overview: String = ""
    var releaseDate: String = ""
    var posterImageUrl: URL!
    var backdropImageUrl: URL!
    
}

protocol MovieDetailsViewContract: AnyObject {
    
    func displayTitle(_ title: String)
    func displayMovieDetails(_ movie: MovieDetailsProps)
    
}

protocol MovieDetailsViewModelContract: AnyObject {
    
    var view: MovieDetailsViewContract! { get set }
    
    func setMovie(_ movie: Movie)
    func fetchMovie()
    
}

