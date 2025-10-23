//
//  ColorSeatModifier.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 22/10/25.
//

import SwiftUI

struct ColorSeatSchemeModifier: ViewModifier {
  @Environment(\.colorScheme) var colorScheme
  var isSelected: Bool
  var seatStatus: String
  
  var status: String {
    return seatStatus.lowercased()
  }
  
  func body(content: Content) -> some View {
    content
      .foregroundStyle(foreGroundColor)
      .background(backColor)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(borderColor, lineWidth: 3)
      )
  }
  
  var backColor: Color {
    guard status.lowercased() != "space" else { return .clear }
    guard status.lowercased() != "sold" else { return backSoldSeat }
    let defaultOpacity: Double = colorScheme == .dark ? 0.0 : 0.5
    return isSelected ? Color.blue : Color.clear.opacity(defaultOpacity)
  }
  
  var borderColor: Color {
    if status.lowercased() != "space" && status.lowercased() != "sold" {
      return colorScheme == .dark ? .blue : isSelected ? .blue : .gray
    }
    return .clear
  }
  
  var foreGroundColor: Color {
    guard status.lowercased() != "sold" else { return foregroundSoldSeat }
    return colorScheme == .dark ? .white : isSelected ? .white : .black
  }
  
  var backSoldSeat: Color {
    let light = Color(red: 236/255, green: 238/255, blue: 241/255)
    let dark = Color(red: 55/255, green: 71/255, blue: 94/255)
    return colorScheme == .dark ? dark : light
  }
  
  var foregroundSoldSeat: Color {
    let light = Color(red: 162/255, green: 172/255, blue: 186/255)
    let dark = Color(red: 199/255, green: 205/255, blue: 214/255)
    return colorScheme == .dark ? dark : light
  }
}
