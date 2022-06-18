//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import UIKit

class MovieDetailsViewController: UIViewController, MovieDetailsViewContract {
    
    var viewModel: MovieDetailsViewModelContract!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.fetchMovie()
    }
    
    
    // MARK: - MovieDetailsViewContract
    
    func displayMovieDetails(_ movie: MovieDetailsProps) {
        
    }

}
