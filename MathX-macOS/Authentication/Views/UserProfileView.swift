import SwiftUI
import GoogleSignIn

struct UserProfileView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser
    }
    
    var body: some View {
        return Group {
            if let userProfile = user?.profile {
                VStack(spacing: 10) {
                    HStack(alignment: .top) {
                        UserProfileImageView(userProfile: userProfile)
                            .padding(.leading)
                        VStack(alignment: .leading) {
                            Text(userProfile.name)
                                .font(.headline)
                            Text(userProfile.email)
                        }
                    }
                    Button(NSLocalizedString("Sign Out", comment: "Sign out button"), action: signOut)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                    
                    Button(NSLocalizedString("Disconnect", comment: "Disconnect button"), action: disconnect)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                    Spacer()
                }
            } else {
                Text(NSLocalizedString("Failed to get user profile!", comment: "Empty user profile text"))
            }
        }
    }
    
    func disconnect() {
        authViewModel.disconnect()
    }
    
    func signOut() {
        authViewModel.signOut()
    }
}
