//
//  ViewController.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewContract {

    var viewModel: MovieListViewModelContract!
    var dataSource: MovieListDataSource!
    @IBOutlet var tableView: UITableView!
    var currentFilter: MovieListType = .popular
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bindViewModel()
    }
    
    func configureViews() {
        configureTableView()
        configureFilterMenu()
    }
    
    private func configureTableView() {
        dataSource = MovieListDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = 180
    }
    
    private func configureFilterMenu() {
        let menuItems = [
            UIAction(title: "Popular") { [unowned self] action in
                self.viewModel.toggleFilter(sorted: .popular)
            },
            UIAction(title: "Top Rated") { [unowned self] action in
                self.viewModel.toggleFilter(sorted: .topRated)
            }
        ]
        let filterMenu = UIMenu(image: UIImage(systemName: "sort_down"), options: .displayInline, children: menuItems)
        self.navigationItem.rightBarButtonItem?.menu = filterMenu
        //self.navigationItem.rightBarButtonItem?.showsMenuAsPrimaryAction = true
    }
    
    func bindViewModel() {
        AppContainer.configure(self)
        viewModel.fetchMovies(sorted: .popular)
    }
    
    deinit {
        viewModel = nil
        dataSource = nil
    }
    
    func toggleFilter(_ value: MovieListType) {
        viewModel.fetchMovies(sorted: value)
    }
    
    
    // MARK: - MovieListViewContract
    
    func displayMovies(_ movies: [MovieListItemProps]) {
        dataSource.setMovies(movies)
        tableView.reloadData()
    }
    
    func displayTitle(_ title: String) {
        self.title = title
    }
 
}


// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectMovie(at: indexPath.row)
        performSegue(withIdentifier: "movieDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MovieDetailsViewController else {
            return
        }
        guard let movie = viewModel.selectedMovie else {
            return
        }
        AppContainer.configure(destination, movie: movie)
    }
    
}
