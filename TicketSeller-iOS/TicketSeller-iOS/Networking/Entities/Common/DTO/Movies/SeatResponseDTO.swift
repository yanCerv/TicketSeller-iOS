//
//  SeatResponseDTO.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 21/10/25.
//

nonisolated struct SeatResponseDTO: Decodable {
  let rows: [SeatRow]
}
