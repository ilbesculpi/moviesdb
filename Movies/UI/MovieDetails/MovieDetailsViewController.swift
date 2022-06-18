//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Ilbert Esculpi on 18/6/22.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController, MovieDetailsViewContract {
    
    var viewModel: MovieDetailsViewModelContract!
    @IBOutlet var moviePanel: UIView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelReleaseDate: UILabel!
    @IBOutlet var labelOverview: UILabel!
    @IBOutlet var imagePoster: UIImageView!
    @IBOutlet var imageBackdrop: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureViews()
    }
    
    func bindViewModel() {
        viewModel.fetchMovie()
    }
    
    func configureViews() {
        moviePanel.layer.cornerRadius = 10
        moviePanel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    // MARK: - MovieDetailsViewContract
    
    func displayMovieDetails(_ movie: MovieDetailsProps) {
        labelTitle.text = movie.title
        labelOverview.text = movie.overview
        labelReleaseDate.text = movie.releaseDate
        
        // movie poster
        let placeholder = UIImage(named: "Placeholder")
        imagePoster.sd_setImage(with: movie.posterImageUrl, placeholderImage: placeholder)
        imageBackdrop.sd_setImage(with: movie.backdropImageUrl, placeholderImage: placeholder)
    }

}
