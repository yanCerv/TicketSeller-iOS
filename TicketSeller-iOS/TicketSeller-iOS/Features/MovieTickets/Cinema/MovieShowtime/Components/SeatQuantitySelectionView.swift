//
//  SeatQuantitySelectionView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

struct SeatQuantitySelectionView: View {
  @EnvironmentObject var navigation: MoviesNavigation
  @Binding var viewModel: MovieShowtimeViewModel
  
  var body: some View {
    VStack(spacing: 3) {
      Text("Selecciona una cantidad")
        .font(.headline)
      Text("max 10 de boletos.")
        .font(.caption2)
        .padding(.bottom)
      Text(viewModel.movieDetailWrapped.title)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.caption)
      Text(viewModel.showtimeSelected.time)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.caption)
        .padding(.bottom)
      Stepper(value: $viewModel.seatQuantity, in: 0...10) {
        Text("\(viewModel.seatQuantity) boleto\(viewModel.seatQuantity == 1 ? "" : "s")")
          .font(.title2.weight(.medium))
      }
      .frame(maxWidth: 210)
      .padding(.bottom, 16)
      
      Button("Continuar") {
        viewModel.showSeatQuantitySelection = false
        navigation.add(.seatSelection(showtime: viewModel.showtimeSelected,
                                      movieDetail: viewModel.movieDetailWrapped,
                                      seatQuantitySelected: viewModel.seatQuantity))
      }
      .modifier(ButtonModifier(isEnabled: viewModel.seatQuantity != 0, maxWidth: .infinity, font: .headline))
    }
    .padding()
    .background(.thinMaterial)
    .cornerRadius(16)
    .shadow(radius: 8)
    .padding(.horizontal)
  }
}
