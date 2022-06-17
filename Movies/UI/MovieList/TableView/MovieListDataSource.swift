//
//  MovieListDataSource.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import UIKit

class MovieListDataSource: NSObject, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell") else {
            fatalError("can't dequeue cell with identifier 'MovieListCell'")
        }
        return cell
    }

}
