//
//  MainFeature.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 27/10/25.
//

enum FeatureType: String, Identifiable {
  case movies
  case football
  case concert
  case theater
  case flying
  case none
  
  init(value: String) {
    self = FeatureType(rawValue: value) ?? .none
  }
  
  var id: Int {
    hashValue
  }
}

struct MainFeature: Decodable, Hashable {
  let id: String
  let title: String
  let type: String
  let isActive: Bool
  let imageUrl: String
  
  var featureType: FeatureType {
    return FeatureType(value: type)
  }
}
