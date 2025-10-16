//
//  ImageCache.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 16/10/25.
//

import SwiftUI

final class ImageCache {
  static let shared = NSCache<NSURL, UIImage>()
}

struct CachedAsyncImage: View {
  private let url: URL?
  
  init(url: URL?) {
    self.url = url
  }
  
  var body: some View {
    if let url = url, let cachedImage = ImageCache.shared.object(forKey: url as NSURL) {
      Image(uiImage: cachedImage)
        .resizable()
        .scaledToFill()
        .frame(width: 140, height: 210)
        .clipped()
        .cornerRadius(12)
    } else if let url = url {
      AsyncImage(url: url) { phase in
        switch phase {
        case .success:
          if let image = phase.image {
            image
            .resizable()
            .scaledToFill()
            .frame(width: 140, height: 210)
            .clipped()
            .cornerRadius(12)
          } 
        case .failure, .empty:
          ProgressView()
            .frame(width: 140, height: 210)
        @unknown default:
          ProgressView()
            .frame(width: 140, height: 210)
        }
      }
    } else {
      ProgressView()
        .frame(width: 140, height: 210)
    }
  }
}

extension Image {
  func asUIImage() -> UIImage? {
    let controller = UIHostingController(rootView: self.resizable())
    let view = controller.view
    
    let targetSize = controller.view.intrinsicContentSize
    let size = CGSize(width: max(1, targetSize.width), height: max(1, targetSize.height))
    
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { _ in
      view?.drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)
    }
  }
}

extension AsyncImagePhase {
  func asUIImage() -> UIImage? {
    switch self {
    case .success(let image):
      return image.asUIImage()
    default:
      return nil
    }
  }
}
