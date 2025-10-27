//
//  QRCodeImageView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 24/10/25.
//

import SwiftUI

struct QRCodeImageView: View {
  
  private let context = CIContext()
  private let filter = CIFilter.qrCodeGenerator()
  
  var bookingId: String
  
  var body: some View {
    qrCodeImage()
      .interpolation(.none)
      .resizable()
      .frame(width: 200, height: 200)
  }
  
  private func qrCodeImage() -> Image {
    let data = Data(bookingId.utf8)
    filter.setValue(data, forKey: "inputMessage")
    
    if let outputImage = filter.outputImage,
       let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      return Image(decorative: cgimg, scale: 1.0)
    }
    return Image(systemName: "xmark.circle")
  }
}
