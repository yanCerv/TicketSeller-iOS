//
//  MoviCardView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

struct MovieCardView: View {
  @EnvironmentObject var navigation: MainNavigation
  let movie: Movie
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      CachedAsyncImage(url: Movie.posterURL(from: movie))
        .onTapGesture {
          navigation.add(.movieShowtimeDetail(id: movie.id))
        }
        .accessibilityLabel(Text(movie.title))
        .accessibilityHint("Toca para ver los horarios de esta película")
      
      Text(movie.title)
        .font(.headline)
        .lineLimit(1)
        .frame(width: 140, alignment: .leading)
      
      Text(movie.releaseDate)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .frame(width: 140, alignment: .leading)
    }
  }
}
