//
//  MovieListDataSource.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import UIKit

class MovieListDataSource: NSObject, UITableViewDataSource {
    
    var movies: [MovieListItemProps] = []
    var fetchMoreRows: Bool = false
    var viewModel: MovieListViewModelContract!
    
    func setMovies(_ movies: [MovieListItemProps]) {
        self.movies = movies
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchMoreRows ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? movies.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            // load more items cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell") else {
                fatalError("can't dequeue cell with identifier 'LoadingCell'")
            }
            viewModel.fetchNextItems()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell") as? MovieListItemTableViewCell else {
            fatalError("can't dequeue cell with identifier 'MovieListCell'")
        }
        let movie = movies[indexPath.row]
        cell.displayMovie(movie)
        return cell
    }

}
