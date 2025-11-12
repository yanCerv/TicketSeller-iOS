//
//  ClassificationList.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 11/11/25.
//

import SwiftUI

struct ClassificationList: View {
  @EnvironmentObject var navigation: EventNavigation
  @State var viewModel: ClassificationListViewModel = ClassificationListViewModel()
  
  var body: some View {
    
    ScrollView {
      LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
        ForEach(viewModel.classifications, id: \.self) { classification in
          VStack {
            Text(classification.segmentName)
              .font(.headline)
              .padding()
              .frame(maxWidth: .infinity)
              .background(Color.brown.opacity(0.15))
              .clipShape(RoundedRectangle(cornerRadius: 12))
          }
        }
      }
      .padding()
      .task {
        await viewModel.fetchClassifications()
      }
    }
    .navigationTitle("Genres")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .toolbar {
      NavigationButton(systemImage: "chevron.left", placement: .topBarLeading) {
        navigation.back()
      }
    }
  }
}

#Preview {
  ClassificationList()
}
