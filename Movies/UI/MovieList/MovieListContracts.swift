//
// Contracts for MovieList Screen.
//

import Foundation

struct MovieListItemProps {
    var title: String = ""
    var imageUrl: String = ""
}

protocol MovieListViewContract: AnyObject {
    
    func displayMovies(_ movies: [MovieListItemProps])
    
}

protocol MovieListViewModelContract: AnyObject {
    
    func fetchMovies()
    
}
