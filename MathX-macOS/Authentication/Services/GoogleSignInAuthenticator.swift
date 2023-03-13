import Foundation
import SwiftUI
import GoogleSignIn

/// An observable class for authenticating via Google.
final class GoogleSignInAuthenticator: ObservableObject {
    private var authViewModel: AuthenticationViewModel
    @AppStorage("isLoggedIn", store: .standard) var isLoggedIn = false
    
    /// Creates an instance of this authenticator.
    /// - parameter authViewModel: The view model this authenticator will set logged in status on.
    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
    }
    
    /// Signs in the user based upon the selected account.'
    /// - note: Successful calls to this will set the `authViewModel`'s `state` property.
    func signIn() {
        guard let presentingWindow = NSApplication.shared.windows.first else {
            print("There is no presenting window!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingWindow) { signInResult, error in
            guard let signInResult = signInResult else {
                print("Error! \(String(describing: error))")
                return
            }
            
            withAnimation {
                self.authViewModel.state = .signedIn(signInResult.user)
                self.isLoggedIn = true
            }
        }
    }
    
    /// Signs out the current user.
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        authViewModel.state = .signedOut
    }
    
    /// Disconnects the previously granted scope and signs the user out.
    func disconnect() {
        GIDSignIn.sharedInstance.disconnect { error in
            if let error = error {
                print("Encountered error disconnecting scope: \(error).")
            }
            self.signOut()
        }
    }
}
