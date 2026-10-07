//
//  SeatButton.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 21/10/25.
//

import SwiftUI

struct SeatButton: View {
  
  var seat: Seat
  let action: () -> Void
  
  var body: some View {
    Button {
      guard seat.status == .available else { return }
      action()
    } label: {
      seatComponent()
        .frame(width: seat.seatWidth, height: 40)
        .font(.system(size: 14, weight: .semibold))
        .modifier(ColorSeatSchemeModifier(isSelected: seat.isSelected, seatStatus: seat.status))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(accessibilityLabel))
        .accessibilityHint(Text(accessibilityHint))
    }
    .buttonStyle(.plain)
    .disabled(seat.status == .sold)
  }
  
  private var accessibilityLabel: String {
    if seat.status == .sold { return "Asiento no disponible" }
    return "Asiento \(seat.seatNumber) - \(seat.type.rawValue.capitalized)"
  }
  
  private var accessibilityHint: String {
    if seat.status == .sold { return "Este asiento está vendido" }
    if seat.isSelected { return "Toca para deseleccionar" }
    return "Toca para seleccionar este asiento"
  }
  
  @ViewBuilder
  func seatComponent() -> some View {
    ZStack {
      VStack(spacing: 2) {
        if seat.status == .sold {
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
