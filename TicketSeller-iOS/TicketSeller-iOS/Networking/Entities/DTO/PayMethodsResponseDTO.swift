//
//  PayMethodsResponseDTO.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

struct PayMethodsResponseDTO: Decodable, Hashable {
  let result: [PayMethod]
}
