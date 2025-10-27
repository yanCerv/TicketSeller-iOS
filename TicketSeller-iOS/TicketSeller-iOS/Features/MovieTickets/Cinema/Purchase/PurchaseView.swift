//
//  PurchaseView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 24/10/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct PurchaseView: View {
  @EnvironmentObject var navigation: MoviesNavigation
  @State var viewModel: PurchaseViewModel
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        Text("Tu boleto")
          .font(.largeTitle)
          .bold()
        
        QRCodeImageView(bookingId: viewModel.purchase.bookingId)
        
        Text("\(viewModel.purchase.bookingId)")
          .font(.headline)
        
        VStack(alignment: .leading, spacing: 8) {
          Text("Película: \(viewModel.movieDetail.title)")
          Text("Horario: \(viewModel.showtime.time)")
          Text("Asientos:")
          ForEach(viewModel.seats, id: \.self) { seat in
            Text("• \(seat.rowSeat) - \(seat.seatNumber) - \(seat.type.rawValue)")
          }
          Text("Total: $\(viewModel.dataPurchase.totalPrice.formattedPrice())")
            .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        
        Button("Guardar y salir") {
          viewModel.checkoutInput.didTapSaveAndExit()
          navigation.backToMain()
        }
        .modifier(ButtonModifier(isEnabled: .constant(true), maxWidth: .infinity))
        .padding()
      }
      .padding()
    }
  }
}
