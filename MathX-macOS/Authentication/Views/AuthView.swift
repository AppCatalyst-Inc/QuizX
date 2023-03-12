import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    
    @State private var progress: CGFloat = 0
    let gradient1 = Gradient(colors: [.purple, .yellow])
    let gradient2 = Gradient(colors: [.blue, .purple])
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var vm = GoogleSignInButtonViewModel(scheme: GoogleSignInButtonColorScheme.light, style: GoogleSignInButtonStyle.wide, state: GoogleSignInButtonState.normal)
    
    @AppStorage("exitedSignIn", store: .standard) var exitedSignIn = Bool()
    @AppStorage("isLoggedIn", store: .standard) var isLoggedIn = Bool()
    
    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser // retrieves user info
    }
    
    var body: some View {
        return Group {
            GeometryReader { geometry in
                VStack {
                    
                }
                .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress) // background animation
                .ignoresSafeArea()
                
                .overlay(
                    VStack {
                        ZStack {
                            if !isLoggedIn {
                                GoogleSignInButton(viewModel: vm, action: authViewModel.signIn)
                                    .cornerRadius(30)
                                    .frame(maxWidth: geometry.size.width / 3)
                            } else {
                                VStack {
                                    if let userProfile = user?.profile {
                                        HStack {
                                            VStack {
                                                Text("Account Information")
                                                    .font(.largeTitle)
                                                    .bold()
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.top)
                                                    .foregroundColor(Color.primary)
                                                
                                                Text("Review account information")
                                                    .font(.callout)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                            
                                            Spacer()
                                            
                                            VStack {
                                                Button {
                                                    authViewModel.signOut()
                                                    isLoggedIn = false
                                                    exitedSignIn = false
                                                    
                                                } label: {
                                                    HStack {
                                                        Image(systemName: "person.crop.circle.badge.xmark")
                                                        Text("Log Out")
                                                    }
                                                    .foregroundColor(.red)
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                    .modifier(FlatGlassView())
                                                }
                                                .buttonStyle(.plain)
                                            }
                                        }
                                        
                                        Divider()
                                            .padding()
                                        
                                        
                                        HStack(spacing: 12) {
                                            UserProfileImageView(userProfile: userProfile)
                                                .frame(width: 64, height: 64)
                                                .padding(.leading)
                                            
                                            VStack(alignment: .leading) {
                                                Text(userProfile.name)
                                                    .font(.title3)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.primary)
                                                
                                                Text(userProfile.email)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                            }
                                            
                                        }
                                        .padding()
                                        
                                        Divider()
                                            .padding()
                                        
                                        Text("By proceeding you accept our **Terms of Service** and **Privacy Policy**")
                                            .font(.footnote)
                                        
                                        Button {
                                            exitedSignIn = true
                                        } label: {
                                            Text("PROCEED")
                                                .bold()
                                                .frame(maxWidth: .infinity, maxHeight: 50)
                                                .background(.blue)
                                                .foregroundColor(.white)
                                                .cornerRadius(14)
                                                .padding(.bottom, 8)
                                        }
                                        .buttonStyle(.plain)
                                        
                                    } else {
                                        Button {
                                            authViewModel.signOut()
                                            isLoggedIn = false
                                            exitedSignIn = false
                                        } label: {
                                            Text("An error occurred while trying to retrieve your account's information. Retry?")
                                        }
                                    }
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .foregroundColor(Color.primary.opacity(0.8))
                                .foregroundStyle(.ultraThinMaterial)
                                .cornerRadius(35)
                                .padding()
                                .padding(.vertical, 10)
                            }
                        }
                    }
                        .frame(width: geometry.size.width / 2)
                        .padding(.horizontal, 50)
                    
                    ,alignment: .center
                )
            }
        }
    }
}
