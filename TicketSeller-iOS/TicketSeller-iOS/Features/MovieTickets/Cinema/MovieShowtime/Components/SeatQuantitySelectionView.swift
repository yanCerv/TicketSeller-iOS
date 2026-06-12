//
//  SeatQuantitySelectionView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

struct SeatQuantitySelectionView: View {
  @State var quantity: Int = 0
  var movieTitle: String
  var time: String
  weak var output: SeatQuantitySelectionOutput?
  let action: () -> Void
    
  var body: some View {
    VStack(spacing: 3) {
      Text("Selecciona una cantidad")
        .font(.headline)
      Text("max 10 de boletos.")
        .font(.caption2)
        .padding(.bottom)
      Text(movieTitle)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.caption)
      Text(time)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.caption)
        .padding(.bottom)
      Stepper(value: $quantity, in: 0...10) {
        Text("\(quantity) boleto\(quantity == 1 ? "" : "s")")
          .font(.title2.weight(.medium))
      }
      .frame(maxWidth: 210)
      .padding(.bottom, 16)
      
      Button("Continuar") {
        output?.didSelect(quantity: quantity)
        action()
      }
      .modifier(ButtonModifier(isEnabled: quantity != 0, maxWidth: .infinity, font: .headline))
    }
    .padding()
    .background(.thinMaterial)
    .cornerRadius(16)
    .shadow(radius: 8)
    .padding(.horizontal)
  }
}
