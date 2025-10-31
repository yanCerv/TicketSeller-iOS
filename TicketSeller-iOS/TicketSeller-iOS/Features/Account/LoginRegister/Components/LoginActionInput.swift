//
//  ProtocolActionInput.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 31/10/25.
//

protocol LoginActionInput: AnyObject {
  func didGet(user: AccountUser)
}
