//
//  PaypalRequest.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 14/10/26.
//

import CorePayments
import PayPalPayments

actor PaypalRequest {
  private let config = CoreConfig(clientID: "<YOUR_CLIENT_ID>",
                                  environment: .sandbox,               // .live for production
                                  merchantID: "<YOUR_MERCHANT_ID>",   // Required, encrypted merchant account ID
                                  bnCode: nil)                     // Partner integrations only
  
  // config + urlConfig from Install and set up
  
  func purchase() {
    // TODO Fueature pending
  //  let checkoutClient = PayPalClient(config: config)
  }
}
