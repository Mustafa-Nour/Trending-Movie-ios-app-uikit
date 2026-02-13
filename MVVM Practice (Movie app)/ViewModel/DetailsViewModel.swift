//
//  DetailsViewModel.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 20/04/2025.
//

import Foundation
class DetailsViewModel {
    var movie: Movie
    var movieImage: URL?
    var movieTitle: String
    var movieDesc: String
    var movieId: Int
    
    init(movie: Movie) {
        self.movie = movie
        // MARK: - Note (you must init all properties before u initialize a property that calls another function --> (make imageURl))
        self.movieId = movie.id
        self.movieDesc = movie.overview ?? ""
        self.movieTitle = movie.name ?? movie.originalTitle ?? movie.originalName ?? ""
    
        self.movieImage = makeImageURL(movie.backdropPath ?? "")
        
    }

    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServerAddress)\(imageCode)")
    }
    
}
