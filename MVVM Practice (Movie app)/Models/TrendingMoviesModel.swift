//
//  TrendingMoviesModel.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 20/02/2025.
//

import Foundation

// MARK: - TrendingMovieModel
struct TrendingMoviesModel: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let name: String?
    let originalName, firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
    }
}



////enum OriginalLanguage: RawRepresentable, Codable {
////    case en
////    case lv
//    case zh
//    case ja
//    case ko
//    case po
//    case pt
//    case da
//    case fr
//    case es
//    case tl
//    case pl
//    case it
//    case unKnown(value: String)
//    var rawValue: String {
//        switch self {
//            
//        case .en: "en"
//        case .da: "da"
//        case .lv: "lv"
//        case .ja: "ja"
//        case .ko: "ko"
//        case.po: "po"
//        case .pt: "pt"
//        case .fr: "fr"
//        case .es: "es"
//        case .tl: "tl"
//        case .pl: "pl"
//        case .it: "it"
//        case .zh: "zh"
//        case let .unKnown(value): value
//
//        }
//    }
//    init(rawValue: String) {
//        switch rawValue.lowercased() {
//        case "en": self = .en
//               case "lv": self = .lv
//               case "zh": self = .zh
//               case "ja": self = .ja
//               case "ko": self = .ko
//               case "po": self = .po
//               case "pt": self = .pt
//               case "da": self = .da
//               case "fr": self = .fr
//               case "es": self = .es
//               case "tl": self = .tl
//               case "pl": self = .pl
//               case "it": self = .it
//        default:
//            self = .unKnown(value: rawValue)
//        }
//    }
//    
//    
//}
//
