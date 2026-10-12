//
//  FeatureSelection.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

struct FeatureSelectionView: View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  @State var viewModel: FeatureSelectionViewModel

  private var columns: [GridItem] {
    Array(
      repeating: GridItem(.flexible(), spacing: 20, alignment: .top),
      count: horizontalSizeClass == .regular ? 3 : 2
    )
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.mainBackgroundGradient
          .ignoresSafeArea()
        
        VStack {
          ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
              ForEach(viewModel.features, id: \.id) { feature in
                FeatureCard(viewModel: viewModel, feature: feature)
              }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          .fullScreenCover(item: $viewModel.featureType, content: { type in
            if type == .movies {
              MoviesView()
                .environmentObject(MoviesNavigation())
            }
            
            if type == .event {
              EventListView()
                .environmentObject(EventNavigation())
            }
            
          })
        }
        .navigationTitle("Ticket Seller")
        .navigationBarTitleDisplayMode(.inline)
        .task {
          await viewModel.fetchFeatures()
        }
      }
    }
  }
}

#Preview {
  FeatureSelectionView(viewModel: FeatureSelectionViewModel())
}
