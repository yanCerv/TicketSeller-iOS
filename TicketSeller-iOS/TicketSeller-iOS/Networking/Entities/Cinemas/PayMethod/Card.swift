//
//  Card.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

struct Card: Codable, Hashable {
  var cardName: String
  var cardNumber: String
  var cardDate: String
  var cardCvc: String
}
