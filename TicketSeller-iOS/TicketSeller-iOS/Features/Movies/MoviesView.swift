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
    ScrollView {
      VStack {
        MovieCardList(title: "En Cartelera", movies: viewModel.nowPlaying)
        MovieCardList(title: "Populares", movies: viewModel.popularMovies)
        MovieCardList(title: "Mas Votados", movies: viewModel.topRatedMovies)
        MovieCardList(title: "Proximamente", movies: viewModel.upcomingMovies)
      }
      .task {
        await viewModel.didFetchData()
      }
    }
    .refreshable {
      await viewModel.didFetchData()
    }
  }
}
