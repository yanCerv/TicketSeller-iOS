//
//  SeatQuantitySelectionOutput.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 12/06/26.
//

protocol SeatQuantitySelectionOutput: AnyObject {
  func didSelect(quantity: Int)
}
