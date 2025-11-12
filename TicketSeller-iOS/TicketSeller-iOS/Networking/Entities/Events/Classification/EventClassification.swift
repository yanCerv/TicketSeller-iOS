//
//  EventClassification.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 11/11/25.
//

import Foundation

struct EventClassification: Decodable {
  let classifications: [Classification]?
}

struct Classification: Decodable, Hashable {
  let segment: SegmentDetail?
  
  var segmentName: String {
    guard let segment = segment else { return "Other" }
    return segment.name
  }
}
