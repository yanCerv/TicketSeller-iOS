//
//  PurchaseResponseDTO.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 24/10/25.
//

import Foundation

struct PurchaseResponseDTO: Decodable, Hashable {
  let result: BookingInfo
}
