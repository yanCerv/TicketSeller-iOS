//
//  EventDate.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import Foundation

struct EventDate: Decodable, Hashable {
  let start: StartDate
}

struct StartDate: Decodable, Hashable {
  let localDate: String?
  let localTime: String?
}
