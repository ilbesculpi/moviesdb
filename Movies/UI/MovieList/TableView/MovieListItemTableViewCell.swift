//
//  MovieListItemCellTableViewCell.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import UIKit

class MovieListItemTableViewCell: UITableViewCell {
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelOverview: UILabel!
    @IBOutlet var imagePoster: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayMovie(_ movie: MovieListItemProps) {
        labelTitle.text = movie.title
    }

}
