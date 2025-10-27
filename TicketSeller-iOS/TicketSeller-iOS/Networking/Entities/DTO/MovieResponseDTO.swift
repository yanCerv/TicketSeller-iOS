//
//  MovieResponseDTO.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

struct MovieResponseDTO: Decodable {
  let page: Int
  let results: [Movie]
  let dates: DateRange?
  let totalPages: Int
  let totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page
    case results
    case dates
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}
