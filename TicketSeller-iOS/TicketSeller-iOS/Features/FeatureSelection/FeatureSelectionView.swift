//
//  FeatureSelection.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

import SwiftUI

struct FeatureSelectionView: View {
    var body: some View {
      List(0..<5) { item in
        Text("Cinema Tickets")
          .font(.system(size: 18, weight: .semibold))
          .foregroundStyle(.primary)
      }
    }
}

#Preview {
  FeatureSelectionView()
}
