//
//  AccountClient.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//


protocol AccountProvider {
  func fetchAccountUser() async -> AccountUser
}

actor AccountClient: AccountProvider {
  
  func fetchAccountUser() async -> AccountUser {
    let response = ResourceJSON.from(fileName: "AccountUser", type: AccountUserResponseDTO.self)
    let dataUser = response.result
    
    return dataUser
  }
}
