//
//  PreferencesView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 02/10/26.
//

import SwiftUI

struct PreferencesView: View {
  
  @State var viewModel: PreferencesViewModel
  @State var navigation: NavigationPreferences
  
  init(navigation: NavigationPreferences) {
    self.navigation = navigation
    viewModel = PreferencesViewModel(navigation: navigation)
  }
  
  var body: some View {
    NavigationStack(path: $navigation.paths) {
      List(viewModel.favoriteMovieList, id: \.self) { movie in
        Button {
          Task {
            await viewModel.didSelectFavorite(movieId: movie.tmdbMovieId)
          }
        } label: {
          HStack {
            Text(movie.title)
            Spacer()
            Image(systemName: "chevron.right")
          }
        }
      }
      .overlay {
        if viewModel.isLoading {
          ProgressLoadingView(typeLoading: .events, text: "Loading Data")
        }
      }
      .task {
        await viewModel.getUserFavorites()
      }
      .navigationDestination(for: PreferencesNavigationpath.self) { path in
        switch path {
        case .navigateToMovie(let movie):
          MovieFavoriteDescriptionView(movie: movie, output: viewModel)
        }
      }
    }
  }
}
