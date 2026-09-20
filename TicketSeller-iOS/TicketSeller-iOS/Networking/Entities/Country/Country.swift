//
//  Country.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 10/11/25.
//

import Foundation

struct Country: Codable, Hashable {
  let id: Int
  let name: String
  let countryCode: String
}
