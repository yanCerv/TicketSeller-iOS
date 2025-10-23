//
//  ZoomResizableView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 21/10/25.
//

import SwiftUI

enum DragState {
  case inactive
  case pressing
  case dragging(translation: CGSize)
  
  var translation: CGSize {
    switch self {
    case .inactive, .pressing:
      return .zero
    case .dragging(let translation):
      return translation
    }
  }
  
  var isPressing: Bool {
    switch self {
    case .pressing, .dragging:
      return true
    case .inactive:
      return false
    }
  }
}

struct ZoomResizableView<Content>: View where Content: View {
  
  @GestureState private var dragState = DragState.inactive
  @Binding var isZooming: Bool
  @Binding var scale: CGFloat
  @State private var position: CGSize = .zero
  @State private var viewOriginalSize: CGSize = .zero
  @State private var parentSize: CGSize = .zero
  @State private var lastScaleValue: CGFloat = 1.0
  private let minScaleDelta: CGFloat = 0.3
  private let maxScaleDelta: CGFloat = 1.3
  
  var content: () -> Content
  
  //MARK: Init
  
  public init(isZooming: Binding<Bool>,
              scale: Binding<CGFloat>,
              content: @escaping () -> Content) {
    self._isZooming = isZooming
    self._scale = scale
    self.content = content
  }
  
  //MARK: Body
  
  var body: some View {
    ZStack {
      content()
        .scaleEffect(scale)
        .offset(
          x: position.width + dragState.translation.width,
          y: position.height + dragState.translation.height
        )
        .background(
          GeometryReader { proxy in
            Color.clear
              .onAppear {
                // Initial size
                self.viewOriginalSize = proxy.size
              }
              .onChange(of: proxy.size) { oldSize, newSize in
                // Handle size changes
                self.viewOriginalSize = newSize
                position = CGSize(
                  width: 0,
                  height: (-parentSize.height / 2) + ((viewOriginalSize.height * scale) / 2)
                )
              }
          }
        )
    }
    .frame(maxWidth: UIScreen.main.bounds.width)
    .background(
      GeometryReader { proxy in
        Color.clear
          .onAppear {
            self.parentSize = proxy.size
          }
          .onChange(of: proxy.size) { oldSize, newSize in
            self.parentSize = newSize
          }
      }
    )
    .onChange(of: parentSize) {
      position = CGSize(width: 0,
                        height: (-parentSize.height / 2) + ((viewOriginalSize.height * scale) / 2)
      )
    }
    .simultaneousGesture(
      MagnificationGesture()
        .onChanged(didChangeMagnification)
        .onEnded(didEndMagnification)
        .simultaneously(with: createLongPressAndDragGesture())
    )
  }
  
  private func height() -> CGFloat {
    let height = (-parentSize.height / 2) + ((viewOriginalSize.height * scale) / 2)
    return height
  }
  
  private func didChangeMagnification(_ value: CGFloat) {
    isZooming = true
    let delta = value / self.lastScaleValue
    self.lastScaleValue = value
    self.scale *= delta
  }
  
  private func didEndMagnification(_ value: CGFloat) {
    if scale < minScaleDelta {
      scale = minScaleDelta
    } else if scale > maxScaleDelta {
      scale = maxScaleDelta
    }
    self.lastScaleValue = 1.0
    self.isZooming = false
    self.position = limitTranslation(dragState.translation)
  }
  
  private func limitTranslation(_ translation: CGSize) -> CGSize {
    let xOffset = translation.width
    let yOffset = translation.height
    let actualWidth = (viewOriginalSize.width * self.scale) / 2.0
    let actualHeight = (viewOriginalSize.height * self.scale) / 2.0
    let parentWidth = parentSize.width * 0.5
    let parentHeight = parentSize.height * 0.5
    let maxWidth = max(actualWidth, parentWidth)
    let maxHeight = max(actualHeight, parentHeight)
    let minWidth = min(-actualWidth, -parentWidth + actualWidth)
    let minHeight = min(-actualHeight, -parentHeight)
    let newWidth = position.width + xOffset
    let newHeight = position.height + yOffset
    
    return CGSize(
      width: min(max(newWidth, minWidth), maxWidth),
      height: min(max(newHeight, minHeight), maxHeight - 90)
    )
  }
  
  private func createLongPressAndDragGesture() -> some Gesture {
    LongPressGesture(minimumDuration: 0.01)
      .sequenced(before: DragGesture())
      .updating($dragState) { value, state, _ in
        switch value {
        case .first(true):
          state = .pressing
        case .second(true, let drag?):
          DispatchQueue.main.async {
            if drag.translation != .zero {
              isZooming = true
            }
          }
          state = .dragging(translation: drag.translation)
        default:
          state = .inactive
        }
      }
      .onEnded { value in
        DispatchQueue.main.async {
          isZooming = false
        }
        guard case .second(true, let drag?) = value else { return }
        position = limitTranslation(drag.translation)
      }
  }
}
