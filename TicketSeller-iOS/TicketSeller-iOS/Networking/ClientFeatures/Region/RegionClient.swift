//
//  Region.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 10/11/25.
//

import Foundation

protocol RegionProdiver {
  func fetchCounties() async throws -> [Country]
}

actor RegionClient: Request, RegionProdiver {
  
  func fetchCounties() async throws -> [Country] {
    
    return []
  }
}
