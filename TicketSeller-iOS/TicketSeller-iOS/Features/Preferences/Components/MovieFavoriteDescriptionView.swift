//
//  MovieFavoriteDescriptionView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 06/10/26.
//

import SwiftUI

protocol MovieFavoriteDescriptionOutput: AnyObject {
  func didRemoveFavorite(id: Int)
}

struct MovieFavoriteDescriptionView: View {
  let movie: MovieDetail
  weak var output: MovieFavoriteDescriptionOutput?
  
  var body: some View {
    ZStack {
      Color.moviesBackgroundGradient
        .ignoresSafeArea()

      ScrollView {
        VStack(alignment: .leading, spacing: 24) {
          FavoriteMovieHero(title: movie.title,
                            posterURL: MovieDetail.posterURL(from: movie),
                            releaseDate: movie.releaseDate,
                            runtime: movie.runtime,
                            genres: movie.genres.map(\.name),
                            voteAverage: movie.voteAverage,
                            voteCount: movie.voteCount)
          
          if let tagline = movie.tagline?.nonEmptyValue {
            FavoriteMovieTagline(tagline: tagline)
          }
          
          FavoriteMovieOverview(overview: movie.overview)
          
          FavoriteMovieAdditionalInfo(originalTitle: movie.originalTitle,
                                      status: movie.status,
                                      spokenLanguages: movie.spokenLanguages.map(\.name))
          
          Button("Remove from favorites") {
            output?.didRemoveFavorite(id: movie.id)
          }
          .modifier(ButtonModifier())
          .frame(height: 45)
          .padding(.all, 16)
        }
        .padding(20)
      }
    }
    .navigationTitle("Movie details")
    .navigationBarTitleDisplayMode(.inline)
  }
}

private struct FavoriteMovieHero: View {
  let title: String
  let posterURL: URL?
  let releaseDate: String?
  let runtime: Int?
  let genres: [String]
  let voteAverage: Double?
  let voteCount: Int?

  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      CachedAsyncImage(url: posterURL, width: 140, height: 210, cornerRadius: 16)
        .accessibilityHidden(true)

      VStack(alignment: .leading, spacing: 12) {
        Text(title)
          .font(.title2.bold())
          .foregroundStyle(Color.ticketPrimaryText)

        FavoriteMovieMetadata(
          releaseDate: releaseDate,
          runtime: runtime,
          genres: genres
        )

        if let voteAverage {
          FavoriteMovieRating(
            voteAverage: voteAverage,
            voteCount: voteCount
          )
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

private struct FavoriteMovieMetadata: View {
  let releaseDate: String?
  let runtime: Int?
  let genres: [String]

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if let releaseDate = releaseDate?.nonEmptyValue {
        Label(releaseDate, systemImage: "calendar")
      }

      if let runtime, runtime > 0 {
        Label("\(runtime) min", systemImage: "clock")
      }

      if !genres.isEmpty {
        Label(genres.joined(separator: " · "), systemImage: "film.stack")
          .lineLimit(3)
      }
    }
    .font(.subheadline)
    .foregroundStyle(Color.ticketPrimaryText.opacity(0.8))
  }
}

private struct FavoriteMovieRating: View {
  let voteAverage: Double
  let voteCount: Int?

  var body: some View {
    HStack(spacing: 6) {
      Image(systemName: "star.fill")
        .foregroundStyle(.yellow)

      Text(voteAverage, format: .number.precision(.fractionLength(1)))
        .fontWeight(.semibold)

      if let voteCount, voteCount > 0 {
        Text("(\(voteCount))")
          .foregroundStyle(Color.ticketPrimaryText.opacity(0.7))
      }
    }
    .font(.subheadline)
    .foregroundStyle(Color.ticketPrimaryText)
    .padding(.horizontal, 10)
    .padding(.vertical, 8)
    .background(Color.ticketPrimaryButton, in: Capsule())
  }
}

private struct FavoriteMovieTagline: View {
  let tagline: String

  var body: some View {
    Text(tagline)
      .font(.title3.italic())
      .foregroundStyle(Color.ticketPrimaryText.opacity(0.82))
  }
}

private struct FavoriteMovieOverview: View {
  let overview: String

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Label("Overview", systemImage: "text.alignleft")
        .font(.headline)
        .foregroundStyle(Color.ticketPrimaryText)

      Text(overview.nonEmptyValue ?? "No overview available.")
        .font(.body)
        .foregroundStyle(Color.ticketPrimaryText.opacity(0.85))
    }
  }
}

private struct FavoriteMovieAdditionalInfo: View {
  let originalTitle: String
  let status: String?
  let spokenLanguages: [String]

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      if originalTitle.nonEmptyValue != nil {
        FavoriteMovieInfoRow(title: "Original title", value: originalTitle)
      }

      if let status = status?.nonEmptyValue {
        FavoriteMovieInfoRow(title: "Status", value: status)
      }

      if !spokenLanguages.isEmpty {
        FavoriteMovieInfoRow(
          title: "Languages",
          value: spokenLanguages.joined(separator: ", ")
        )
      }
    }
    .padding(16)
    .background(Color.ticketPrimaryButton, in: RoundedRectangle(cornerRadius: 16))
  }
}

private struct FavoriteMovieInfoRow: View {
  let title: String
  let value: String

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title)
        .font(.caption.weight(.semibold))
        .foregroundStyle(Color.ticketPrimaryText.opacity(0.7))

      Text(value)
        .font(.subheadline)
        .foregroundStyle(Color.ticketPrimaryText)
    }
  }
}

private extension String {
  var nonEmptyValue: String? {
    isEmpty ? nil : self
  }
}
