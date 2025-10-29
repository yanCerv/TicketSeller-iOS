//
//  Color+Extension.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 28/10/25.
//

import Foundation
import SwiftUI

extension Color {
  static let mainBackgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color(red: 97/255, green: 64/255, blue: 51/255),
                                Color(red: 59/255, green: 48/255, blue: 36/255),
                                Color(red: 85/255, green: 72/255, blue: 51/255)
                               ]),
    startPoint: .top,
    endPoint: .bottom
  )
  
  static let moviesBackgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color(red: 48/255, green: 32/255, blue: 25/255),
                                Color(red: 30/255, green: 20/255, blue: 15/255)
                               ]),
    startPoint: .top,
    endPoint: .bottom)
  
  static let eventsBackgroundGradint = LinearGradient(
    gradient: Gradient(colors: [Color.blue.opacity(0.3),
                                Color.brown.opacity(0.3)]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing
  )
  
  static let mainColor: Color = Color.brown.opacity(0.8)
  static let grayOpacity: Color = Color.gray.opacity(0.5)

  static let ticketPrimaryButton = Color.white.opacity(0.15)
  static let ticketPrimaryText = Color.white.opacity(0.95)
  static let ticketDivider = Color.white.opacity(0.8)
}

