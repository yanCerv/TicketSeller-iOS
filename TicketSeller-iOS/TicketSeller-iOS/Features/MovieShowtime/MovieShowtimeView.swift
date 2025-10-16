//
//  MovieShowtimeView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

struct MovieShowtimeView: View {
  
  @State var viewModel: MovieSwhotimeViewModel
  
  var body: some View {
    Text("MovieShowtimeView")
      .task {
        await viewModel.didFetchData()
      }
  }
}
