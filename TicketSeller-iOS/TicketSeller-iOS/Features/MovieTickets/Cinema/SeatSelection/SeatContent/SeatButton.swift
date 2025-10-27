//
//  SeatButton.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 21/10/25.
//

import SwiftUI

struct SeatButton: View {
  
  var seat: Seat
  let action: (Seat, Bool) -> Void
  
  var body: some View {
    Button {
      // only allow selection if seat is not a space and not sold
      let status = seat.status.lowercased()
      if status != "space" && status != "sold" {
        if seat.isSelected {
          action(seat, false)
        } else {
          action(seat, true)
        }
      }
    } label: {
      seatComponent()
        .frame(width: seat.seatWidth, height: 40)
        .font(.system(size: 14, weight: .semibold))
        .interactiveDismissDisabled(seat.status.lowercased() == "sold" || seat.status.lowercased() == "space")
        .modifier(ColorSeatSchemeModifier(isSelected: seat.isSelected, seatStatus: seat.status))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(accessibilityLabel))
        .accessibilityHint(Text(accessibilityHint))
    }
    .buttonStyle(.plain)
    .disabled(seat.status.lowercased() == "space")
  }
  
  private var accessibilityLabel: String {
    if seat.status.lowercased() == "space" { return "Espacio" }
    if seat.status.lowercased() == "sold" { return "Asiento no disponible" }
    return "Asiento \(seat.seatNumber) - \(seat.type.rawValue.capitalized)"
  }
  
  private var accessibilityHint: String {
    if seat.status.lowercased() == "sold" { return "Este asiento está vendido" }
    if seat.isSelected { return "Toca para deseleccionar" }
    return "Toca para seleccionar este asiento"
  }
  
  @ViewBuilder
  func seatComponent() -> some View {
    let status = seat.status.lowercased()
    
    if status == "space" {
      Color.clear
    } else {
      ZStack {
        VStack(spacing: 2) {
          if status.lowercased() == "sold" {
            Image(systemName: "xmark")
              .font(.system(size: 12, weight: .bold))
              .foregroundColor(.white)
          } else {
            Text(seat.seatNumber)
              .font(.system(size: 12, weight: .semibold))
              .foregroundColor(.primary)
          }
        }
        .padding(6)
      }
    }
  }
  
  private func shortLabel(for type: SeatType) -> String {
    switch type {
    case .motion: return "M"
    case .confort: return "C"
    case .premium: return "P"
    case .sofa: return "S"
    case .relax: return "R"
    case .space: return ""
    }
  }
}
