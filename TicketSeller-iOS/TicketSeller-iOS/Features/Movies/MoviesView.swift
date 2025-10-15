//
//  MoviesView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import SwiftUI

struct MoviesView: View {
  
  @State var viewModel: MoviesViewModel = MoviesViewModel()
  
  var body: some View {
    Text("MoviesView")
      .task {
        await viewModel.didFetchMovies()
      }
  }
}
