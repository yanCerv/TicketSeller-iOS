//
//  MovieCardList.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

struct MovieCardList: View {
  @EnvironmentObject var navigation: MoviesNavigation
  let title: String
  let movies: [Movie]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.title2)
        .bold()
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 16) {
          ForEach(movies, id: \.self) { movie in
            MovieCardView(movie: movie)
          }
        }
        .padding(.horizontal)
      }
    }
  }
}
