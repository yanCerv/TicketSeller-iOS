//
//  MoviesView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import SwiftUI

struct MoviesView: View {
  @EnvironmentObject private var navigation: MainNavigation
  @State var viewModel: MoviesViewModel = MoviesViewModel()
  
  var body: some View {
    NavigationStack(path: $navigation.paths) {
      ScrollView {
        VStack {
          MovieCardList(title: "En emisión", movies: viewModel.nowPlaying)
          MovieCardList(title: "Populares", movies: viewModel.popularMovies)
          MovieCardList(title: "Mas Votados", movies: viewModel.topRatedMovies)
          MovieCardList(title: "Proximamente", movies: viewModel.upcomingMovies)
        }
        .task {
          await viewModel.didFetchData()
        }
      }
      .refreshable {
        await viewModel.didReloadData()
      }
      .navigationTitle("Cartelera")
      .navigationBarTitleDisplayMode(.inline)
      .navigationDestination(for: MainNavigationPath.self) { path in
        switch path {
        case .movieShowtimeDetail(let id):
          MovieShowtimeView(viewModel: MovieSwhotimeViewModel(movieId: id))
        }
      }
    }
  }
}
