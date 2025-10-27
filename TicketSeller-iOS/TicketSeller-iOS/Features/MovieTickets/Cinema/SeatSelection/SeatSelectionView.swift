//
//  SeatSelectionView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

struct SeatSelectionView: View {
  @EnvironmentObject var navigation: MoviesNavigation
  @State var viewModel: SeatSelectionViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      
      ScrollView {
        MovieHeaderView(movie: viewModel.movieDetail)
        HStack(alignment: .top, spacing: 8) {
          Text("Horario:")
            .font(.headline)
          Text(viewModel.showtime?.time ?? "-")
            .font(.body)
        }
        HStack(alignment: .top, spacing: 8) {
          Text("Boletos:")
            .font(.headline)
          Text("\(viewModel.dataPurchase.seatQuantitySelected)")
            .font(.body)
        }
        
        VStack {
          Text("Screen")
            .foregroundStyle(Color.white)
            .font(.system(size: 8, weight: .semibold))
        }
        .frame(maxWidth: .infinity, maxHeight: 10)
        .background(Color.secondary)
        
        SeatContent(viewModel: viewModel)
      }
      
      Button("Continuar") {
        navigation.add(.checkout(dataPurchase: viewModel.dataPurchase))
      }
      .modifier(ButtonModifier(isEnabled: $viewModel.isActiveButton, maxWidth: .infinity))
    }
    .padding()
    .task {
      await viewModel.fetchSeats()
    }
  }
}
