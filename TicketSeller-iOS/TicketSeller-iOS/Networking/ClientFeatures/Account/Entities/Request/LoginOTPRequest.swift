//
//  LoginOTPRequest.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes  on 23/09/26.
//

import Foundation

nonisolated struct RequestLoginOTP: Encodable {
  let email: String
}

nonisolated struct VerifyLoginOTP: Encodable {
  let email: String
  let otp: String
}
