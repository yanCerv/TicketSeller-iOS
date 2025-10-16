//
//  Movie.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import SwiftUI

struct Movie: Decodable, Hashable {
  let id: Int
  let title: String
  let originalTitle: String
  let overview: String
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String
  let originalLanguage: String
  let voteAverage: Double
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case originalTitle = "original_title"
    case overview
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case originalLanguage = "original_language"
    case voteAverage = "vote_average"
  }
  
  static func posterURL(from movie: Movie) -> URL? {
    guard let posterPath = movie.posterPath else { return nil }
    return URL(string: "\(Constants.movieUrl)\(Constants.movieSize)\(posterPath)")
  }
}

struct DateRange: Decodable {
  let maximum: String
  let minimum: String
}
