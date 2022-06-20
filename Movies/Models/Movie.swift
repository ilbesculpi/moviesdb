//
//  Movie.swift
//  Movies
//
//  Created by Ilbert Esculpi on 17/6/22.
//

import Foundation

struct Movie: Decodable {
    
    var id: Int
    var title: String = ""
    var overview: String = ""
    
    var poster_path: String? = ""
    var backdrop_path: String? = ""
    var original_language: String = ""
    var original_title: String = ""
    var popularity: Float = 0
    var adult: Bool = false
    var release_date: String = ""
    var video: Bool = false
    var vote_average: Float = 0
    var vote_count: Float = 0
    
    var posterUrl: String {
        get {
            if let path = poster_path {
                return "https://image.tmdb.org/t/p/w500/\(path)"
            }
            return "https://pbs.twimg.com/profile_images/1243623122089041920/gVZIvphd_400x400.jpg"
        }
    }
    
    var backdropUrl: String {
        get {
            if let path = backdrop_path {
                return "https://image.tmdb.org/t/p/w500/\(path)"
            }
            return "https://pbs.twimg.com/profile_images/1243623122089041920/gVZIvphd_400x400.jpg"
        }
    }
    
    var releaseDateObj: Date? {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: release_date)
        }
    }
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
}
