//
//  CountrySelectionView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 14/10/25.
//

import SwiftUI

struct CountrySelectionView: View {
  
  @State var viewModel: CountrySelectionViewModel = CountrySelectionViewModel()
  
  var body: some View {
    VStack {
      Text("View")
        .task {
          await viewModel.fetchCountries()
        }
    }
  }
}

#Preview {
  CountrySelectionView(viewModel: CountrySelectionViewModel())
}
