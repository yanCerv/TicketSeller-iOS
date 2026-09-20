//
//  MoviesView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import SwiftUI

struct MoviesView: View {
  @EnvironmentObject private var navigation: MoviesNavigation
  
  @State var viewModel: MoviesViewModel = MoviesViewModel()
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack(path: $navigation.paths) {
      ZStack {
        Color.moviesBackgroundGradient
        .ignoresSafeArea()
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
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
          BackToolbarButton {
            dismiss()
          }
        }
        .navigationDestination(for: MoviesNavigationPath.self) { path in
          switch path {
          case .movieShowtimeDetail(let id):
            MovieShowtimeView(viewModel: MovieShowtimeViewModel(movieId: id))
            
          case .seatSelection(let showtime, let movieDetail, let seatQuantitySelected):
            SeatSelectionView(viewModel: SeatSelectionViewModel(movieDetail: movieDetail,
                                                                showtime: showtime,
                                                                seatQuantitySelected: seatQuantitySelected))
            
          case .checkout(let dataPurchase):
            CheckoutView(viewModel: CheckoutViewModel(dataPurchase: dataPurchase))
          }
        }
      }
    }
  }
}

#Preview {
  MoviesView()
    .environmentObject(MoviesNavigation())
}
