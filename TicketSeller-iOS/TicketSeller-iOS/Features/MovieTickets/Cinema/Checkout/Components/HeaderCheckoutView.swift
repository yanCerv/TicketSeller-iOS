//
//  HeaderCheckoutView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

import SwiftUI

struct HeaderCheckoutView: View {
  
  let viewModel: CheckoutViewModel
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      AsyncImage(url: MovieDetail.posterURL(from: viewModel.movieDetail)) { image in
        image
          .resizable()
          .scaledToFill()
      } placeholder: {
        Color.gray.opacity(0.2)
      }
      .frame(width: 80, height: 120)
      .clipShape(RoundedRectangle(cornerRadius: 8))

      VStack(alignment: .leading, spacing: 6) {
        Text(viewModel.movieDetail.title)
          .font(.headline)
        Text("\(viewModel.movieDetail.releaseDateWrapp.prefix(4)) • \(viewModel.movieDetail.runtimeWrapp) min")
          .font(.subheadline)
          .foregroundColor(.secondary)
        Text(viewModel.movieDetail.genres.compactMap(\.name).joined(separator: ", "))
          .font(.subheadline)
          .foregroundColor(.secondary)
        Text("Horario: \(viewModel.showtime.time)")
          .font(.subheadline)
        Text("Boletos: \(viewModel.selectedSeats.count) (\(viewModel.selectedSeats.map { "\($0.rowSeat)-\($0.seatNumber)-\($0.type.rawValue)"}.joined(separator: ", ")))")
          .font(.subheadline)
      }
    }
  }
}
