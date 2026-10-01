import GoogleSignIn
import UIKit

@MainActor
enum GoogleSignInClient {
  static func credential() async throws -> SocialCredential {
    guard let presentingViewController = UIApplication.shared.connectedScenes
      .compactMap({ $0 as? UIWindowScene })
      .first(where: { $0.activationState == .foregroundActive })?
      .windows
      .first(where: \.isKeyWindow)?
      .rootViewController else {
      throw ErrorHandler.googleViewPresentationMissing
    }

    return try await withCheckedThrowingContinuation {
      (continuation: CheckedContinuation<SocialCredential, Error>) in
      GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
        if let error {
          continuation.resume(throwing: error)
          return
        }
        guard let idToken = result?.user.idToken?.tokenString else {
          continuation.resume(throwing: ErrorHandler.googleMissingIDToken)
          return
        }
        continuation.resume(returning: SocialCredential(idToken: idToken))
      }
    }
  }
}
