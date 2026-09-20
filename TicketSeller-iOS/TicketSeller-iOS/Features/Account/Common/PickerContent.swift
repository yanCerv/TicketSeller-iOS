//
//  PickerContent.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 30/10/25.
//

import SwiftUI

struct PickerContent: View {
  @Environment(\.dismiss) var dismiss
  var title: String
  var data: [String]
  @Binding var selected: String
  
  var body: some View {
    VStack {
      
      Text(title)
        .font(.headline)
        .padding(.top, 16)
      Picker("", selection: $selected) {
        ForEach(data, id: \.self) { dataString in
          Text("\(dataString)")
        }
      }
      .pickerStyle(.wheel)

      Button("Cerrar") {
        dismiss()
      }
      .padding(.bottom, 16)
    }
    .presentationDetents([.fraction(0.30)])
  }
}

