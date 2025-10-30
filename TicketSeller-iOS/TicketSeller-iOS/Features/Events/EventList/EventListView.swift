//
//  EventListView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI

struct EventListView: View {
  @EnvironmentObject var navigation: EventNavigation
  @Environment(\.dismiss) var dismiss

  @State var viewModel: EventListViewModel = EventListViewModel()
  
  var body: some View {
    NavigationStack(path: $navigation.paths) {
      ZStack {
        Color.eventsBackgroundGradint
        .ignoresSafeArea()
        
        ScrollView {
          LazyVStack(spacing: 16) {
            ForEach(viewModel.events, id: \.self) { event in
              VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: event.imageUrl) { phase in
                  switch phase {
                  case .success(let image):
                    image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                  default:
                    Color.gray.opacity(0.2)
                  }
                }
                .frame(height: 180)
                .clipped()
                .cornerRadius(12)
                
                
                Text(event.name)
                  .font(.headline)
                  .foregroundStyle(.primary)
                  .padding(.horizontal)
                  .padding(.bottom, 8)
              }
              .background(Color.white.opacity(0.1))
              .cornerRadius(12)
              .padding(.horizontal)
            }
          }
          .padding(.top)
          .task {
            await viewModel.fetchEvents()
          }
          .navigationTitle("Events")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
            BackToolbarButton {
              dismiss()
            }
          }
        }
      }
    }
  }
}
