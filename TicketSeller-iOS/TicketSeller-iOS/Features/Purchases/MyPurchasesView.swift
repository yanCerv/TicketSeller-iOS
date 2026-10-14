//
//  MyPurchasesView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 04/11/25.
//

import SwiftUI

struct MyPurchasesView: View {
  @EnvironmentObject var navigation: MyPurchasesNagivation
  @State var viewModel: MyPurchasesViewModel = MyPurchasesViewModel()
  
  var body: some View {
    NavigationStack {
      VStack {
        List(viewModel.purchases, id: \.self) { purchase in
          HStack {
            Text(purchase.movie.title)
            Spacer()
            Image(systemName: "chevron.right")
          }
        }
        .backgroundStyle(.clear)
      }
      .navigationTitle("Mis Compras")
      .navigationBarTitleDisplayMode(.inline)
      .task {
        await viewModel.getPurchases()
      }
    }
  }
}
