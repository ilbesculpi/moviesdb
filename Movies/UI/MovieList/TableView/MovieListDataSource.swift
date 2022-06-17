//
//  MovieListDataSource.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import UIKit

class MovieListDataSource: NSObject, UITableViewDataSource {
    
    var movies: [MovieListItemProps] = []
    
    func setMovies(_ movies: [MovieListItemProps]) {
        self.movies = movies
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell") as? MovieListItemTableViewCell else {
            fatalError("can't dequeue cell with identifier 'MovieListCell'")
        }
        let movie = movies[indexPath.row]
        cell.displayMovie(movie)
        return cell
    }

}
