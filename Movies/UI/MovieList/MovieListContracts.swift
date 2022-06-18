//
// Contracts for MovieList Screen.
//

import Foundation

struct MovieListItemProps {
    var title: String = ""
    var overview: String = ""
    var date: String = ""
    var imageUrl: URL?
}

protocol MovieListViewContract: AnyObject {
    
    func displayMovies(_ movies: [MovieListItemProps])
    func displayTitle(_ title: String)
    
}

protocol MovieListViewModelContract: AnyObject {
    
    var view: MovieListViewContract! { get set }
    var selectedMovie: Movie? { get }
    
    func fetchMovies(sorted: MovieListType)
    func toggleFilter(sorted: MovieListType)
    func selectMovie(at index: Int)
    
}
