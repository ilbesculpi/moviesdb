//
//  ViewController.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewContract {

    var viewModel: MovieListViewModelContract!
    @IBOutlet var tableView: UITableView!
    var dataSource: MovieListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bindViewModel()
    }
    
    func configureViews() {
        dataSource = MovieListDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func bindViewModel() {
        AppContainer.configure(self)
        viewModel.fetchMovies()
    }
    
    deinit {
        viewModel = nil
        dataSource = nil
    }
    
    
    // MARK: - MovieListViewContract
    
    func displayMovies(_ movies: [MovieListItemProps]) {
        
    }
 
}


// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
