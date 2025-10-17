//
//  MovieShowtimeView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

struct MovieShowtimeView: View {
  @EnvironmentObject var navigation: MainNavigation
  @State var viewModel: MovieShowtimeViewModel
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        
        MovieHeaderView(movie: viewModel.movieDetailWrapped)
        
        Text("Horarios disponibles")
          .font(.title2)
          .bold()
          .padding(.top)
        
        ForEach(viewModel.movieShowtimeWrapped.showtimes, id: \.self) { showtime in
          ShowtimeCardView(showtime: showtime) { selectedShowtime in
            viewModel.didSelected(selectedShowtime)
          }
        }
      }
      .padding()
    }
    .sheet(isPresented: $viewModel.showSeatQuantitySelection) {
      SeatQuantitySelectionView(viewModel: $viewModel)
        .presentationDetents([.fraction(0.35)])
    }
    .task {
      await viewModel.didFetchData()
    }
  }
}

struct MovieHeaderView: View {
  let movie: MovieDetail

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      CachedAsyncImage(url: MovieDetail.posterURL(from: movie))

      VStack(alignment: .leading, spacing: 6) {
        Text(movie.title)
          .font(.title3)
          .bold()

        Text("Duración: \(movie.runtimeWrapp) min")
        Text("Año: \(movie.releaseDateWrapp.prefix(4))")
        Text("Géneros: \(movie.genres.compactMap { $0.name }.joined(separator: ", "))")
      }
      .font(.subheadline)
    }
  }
}

struct MovieDescriptionView: View {
  let movie: MovieDetail
  
  var body: some View {
    Text(movie.overview)
      .font(.body)
      .foregroundColor(.secondary)
      .padding(.top, 8)
  }
}

struct ShowtimeCardView: View {
  let showtime: Showtime
  let onSelect: (Showtime) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        VStack(alignment: .center, spacing: 4) {
          Text(showtime.time)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)

          Text("\(showtime.cinema) • \(showtime.screenType)")
            .font(.footnote)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        VStack {
          Text(showtime.price, format: .currency(code: "USD"))
            .font(.subheadline)
          Button {
            onSelect(showtime)
          } label: {
            Text("Seleccionar")
              .font(.caption.weight(.semibold))
              .padding(.vertical, 6)
              .padding(.horizontal, 12)
              .background(
                RoundedRectangle(cornerRadius: 6)
                  .fill(Color.accentColor.opacity(0.1))
              )
          }
          .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(8)
  }
}
