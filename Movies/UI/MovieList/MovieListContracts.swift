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
    
    func displayMovies(_ movies: [MovieListItemProps], fetchMore: Bool)
    func displayTitle(_ title: String)
    
}

protocol MovieListViewModelContract: AnyObject {
    
    var view: MovieListViewContract! { get set }
    var selectedMovie: Movie? { get }
    
    func toggleFilter(sorted: MovieListType)
    func fetchMovies(sorted: MovieListType)
    func fetchNextItems()
    func selectMovie(at index: Int)
    
}
