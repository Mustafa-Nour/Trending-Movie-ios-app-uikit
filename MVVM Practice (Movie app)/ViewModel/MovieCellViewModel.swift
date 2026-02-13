//
//  MovieCellViewModel.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 26/02/2025.
//

import Foundation

class MovieCellViewModel {
    var id: Int
    var name: String
    var date: String
    var score:String?
    var imageURl: URL?
    
    init (movie: Movie) {
        self.id = movie.id
        self.name = movie.name ?? movie.originalName ?? movie.title ?? movie.originalTitle ?? ""
        self.date  = movie.releaseDate ?? "2025"
        self.score = String(format: "%.1f", movie.voteAverage)
        self.imageURl = makeImageURL(movie.posterPath ?? "")
    }

    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServerAddress)\(imageCode)")
        
    }
}
