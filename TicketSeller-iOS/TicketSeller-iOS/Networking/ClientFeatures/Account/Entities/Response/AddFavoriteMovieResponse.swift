//
//  AddFavoriteMovieResponse.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 02/10/26.
//

struct AddFavoriteMovieResponse: Decodable {
  let id: String
  let userId: String
  let tmdbMovieId: Int
  let title: String
  let createdAt: String
}
