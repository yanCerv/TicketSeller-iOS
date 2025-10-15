//
//  ClientURLSession.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 15/10/25.
//

import Foundation

final class ClientURLSession: NSObject, URLSessionDelegate {
  func urlSession(_ session: URLSession, didReceive
                  challenge: URLAuthenticationChallenge,
                  completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    guard let serverTrust = challenge.protectionSpace.serverTrust else {
      completionHandler(.cancelAuthenticationChallenge, nil)
      return
    }
    
    let policy = SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString)
    var trustResult: SecTrust?
    let status = SecTrustCreateWithCertificates(serverTrust, policy, &trustResult)
    
    guard status == errSecSuccess,
          let trust = trustResult else {
      completionHandler(.useCredential, nil)
      return
    }
    
    var trustResultError: CFError?
    let isValid = SecTrustEvaluateWithError(trust, &trustResultError)
    
    if let _ = trustResultError,
       !isValid {
      completionHandler(.cancelAuthenticationChallenge, nil)
    } else {
      let credential = URLCredential(trust: trust)
      completionHandler(.useCredential, credential)
    }
  }
}
