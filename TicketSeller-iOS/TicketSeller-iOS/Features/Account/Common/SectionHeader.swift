//
//  SectionHeader.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI

struct SectionHeader: View {
  
  let title: String
  
  var body: some View {
    Text(title)
      .frame(maxWidth: .infinity, alignment: .leading)
      .font(.system(size: 18, weight: .semibold))
      .foregroundStyle(.primary)
      .padding(.horizontal, 16)
  }
}
