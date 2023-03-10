import SwiftUI
import GoogleSignIn

struct AuthView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        return Group {
            VStack {
                switch authViewModel.state {
                case .signedIn:
                    UserProfileView()
                        .navigationTitle(
                            NSLocalizedString(
                                "User Profile",
                                comment: "User profile navigation title"
                            ))
                case .signedOut:
                    SignInView()
                        .navigationTitle(
                            NSLocalizedString(
                                "Sign-in with Google",
                                comment: "Sign-in navigation title"
                            ))
                }
            }
        }
    }
}
