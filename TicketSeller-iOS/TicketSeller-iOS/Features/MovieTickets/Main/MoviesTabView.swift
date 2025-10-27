//
//  MainView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

struct MoviesTabView: View {
  
  @State var viewModel: MoviesTabViewModel = MoviesTabViewModel()
  
  var body: some View {
    TabView {
      Tab {
        MoviesView()
          .environmentObject(MoviesNavigation())
      } label: {
        Label("Billboard", systemImage: "film")
      }
      Tab {
        Text("List purchases")
      } label: {
        Label("Purchases", systemImage: "list.bullet.below.rectangle")
      }
    }
  }
}
