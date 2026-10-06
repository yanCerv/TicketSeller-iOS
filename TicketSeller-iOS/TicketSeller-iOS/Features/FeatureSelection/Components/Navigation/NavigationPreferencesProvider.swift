//
//  NavigationPreferences.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 06/10/26.
//

import SwiftUI

protocol NavigationPreferencesProvider: AnyObject {
  func navigateTo(movie: MovieDetail)
  func backTo()
}

extension NavigationPreferences: NavigationPreferencesProvider {
  
  func navigateTo(movie: MovieDetail) {
    add(.navigateToMovie(movie: movie))
  }
  
  func backTo() {
    back()
  }
}
