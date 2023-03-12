import GoogleSignIn
import SwiftUI

struct UserProfileImageView: View {
    
    @ObservedObject var userProfileImageLoader: UserProfileImageLoader
    
    init(userProfile: GIDProfileData) {
        self.userProfileImageLoader = UserProfileImageLoader(userProfile: userProfile)
    }
    
    var body: some View {
        Image(nsImage: userProfileImageLoader.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaledToFit()
            .clipShape(Circle())
            .accessibilityLabel(Text("User profile image."))
    }
}
