//
// Contracts for MovieList Screen.
//

import Foundation

struct MovieListItemProps {
    var title: String = ""
    var imageUrl: URL?
}

protocol MovieListViewContract: AnyObject {
    
    func displayMovies(_ movies: [MovieListItemProps])
    
}

protocol MovieListViewModelContract: AnyObject {
    
    var view: MovieListViewContract! { get set }
    
    func fetchMovies(sorted: MovieListType)
    
}
