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
        bindViewModel()
        configureViews()
    }
    
    func configureViews() {
        configureTableView()
        configureFilterMenu()
    }
    
    private func configureTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = CGFloat(MovieListItemTableViewCell.cellHeight)
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
    }
    
    func bindViewModel() {
        AppContainer.configure(self)
        viewModel.fetchMovies(sorted: .popular)
        dataSource = MovieListDataSource()
        dataSource.viewModel = viewModel
    }
    
    deinit {
        viewModel = nil
        dataSource = nil
    }
    
    func toggleFilter(_ value: MovieListType) {
        viewModel.fetchMovies(sorted: value)
    }
    
    
    // MARK: - MovieListViewContract
    
    func displayMovies(_ movies: [MovieListItemProps], fetchMore: Bool) {
        dataSource.setMovies(movies)
        dataSource.fetchMoreRows = fetchMore
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? CGFloat(MovieListItemTableViewCell.cellHeight) : 60
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
