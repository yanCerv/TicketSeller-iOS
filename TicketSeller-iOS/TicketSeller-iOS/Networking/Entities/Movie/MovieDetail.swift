//
//  MovieDetail.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import Foundation

struct MovieDetail: Decodable, Hashable {
  let id: Int
  let title: String
  let originalTitle: String
  let overview: String
  let tagline: String?
  let homepage: String?
  let posterPath: String?
  let backdropPath: String?
  let runtime: Int?
  let budget: Int?
  let revenue: Int?
  let releaseDate: String?
  let status: String?
  let popularity: Double?
  let voteAverage: Double?
  let voteCount: Int?
  let adult: Bool
  let genres: [Genre]
  let productionCompanies: [ProductionCompany]
  let productionCountries: [ProductionCountry]
  let spokenLanguages: [SpokenLanguage]
  
  var runtimeWrapp: Int {
    guard let runtime else { return 0 }
    return runtime
  }
  
  var releaseDateWrapp: String{
    guard let releaseDate else { return "" }
    return releaseDate
  }
  
  enum CodingKeys: String, CodingKey {
    case id, title, overview, tagline, homepage, runtime, budget, revenue, status, popularity, adult
    case originalTitle = "original_title"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case genres
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case spokenLanguages = "spoken_languages"
  }
  
  static func posterURL(from movieDetail: MovieDetail) -> URL? {
    guard let posterPath = movieDetail.posterPath else { return nil }
    return URL(string: "\(Constants.movieUrl)\(Constants.movieSize)\(posterPath)")
  }
}

struct Genre: Decodable, Hashable {
  let id: Int
  let name: String
}

struct ProductionCompany: Decodable, Hashable {
  let id: Int
  let name: String
  let logoPath: String?
  let originCountry: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case logoPath = "logo_path"
    case originCountry = "origin_country"
  }
}

struct ProductionCountry: Decodable, Hashable {
  let iso3166_1: String
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case iso3166_1 = "iso_3166_1"
    case name
  }
}

struct SpokenLanguage: Decodable, Hashable {
  let englishName: String
  let iso639_1: String
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case englishName = "english_name"
    case iso639_1 = "iso_639_1"
    case name
  }
}
