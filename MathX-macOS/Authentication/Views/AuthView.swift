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
    @AppStorage("secondaryLevel", store: .standard) var secondaryLevel = Int()

    @AppStorage("isDarkMode") var isDarkMode = 1
    
    @Environment(\.colorScheme) var scheme
    let blur: CGFloat = 60
        
    private var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser // retrieves user info
    }
    
    var body: some View {
        return Group {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    ZStack {
                        
                        withAnimation {
                            accountInfoCard()
                                .opacity(isLoggedIn ? 1 : 0)
                        }
                        
                        if !isLoggedIn {
                            VStack(alignment: .leading) {
                                Text("Welcome to QuizX!")
                                    .font(.system(size: 48))
                                    .fontWeight(.heavy)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)
                                    .foregroundColor(.white)
                                
                                GoogleSignInButton(viewModel: vm, action: authViewModel.signIn)
                                    .cornerRadius(30)
                                
                                
                            }
                            .padding()
                            .padding(.vertical)
//                            .background(.ultraThinMaterial)
//                            .foregroundColor(Color.primary.opacity(0.8))
//                            .foregroundStyle(.ultraThinMaterial)
//                            .cornerRadius(16)
                            .padding()
                            .frame(width: geometry.size.width / 2)
                            .frame(height: 120)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(maxHeight: .infinity, alignment: .center)
                            
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 50)
                .background(
                    ZStack {
                        Theme.generalBackground
                        ZStack {
                            Cloud(proxy: geometry,
                                  color: Theme.ellipsesBottomTrailing(forScheme: scheme),
                                  rotationStart: 0,
                                  duration: 60,
                                  alignment: .bottomTrailing)
                            Cloud(proxy: geometry,
                                  color: Theme.ellipsesTopTrailing(forScheme: scheme),
                                  rotationStart: 240,
                                  duration: 50,
                                  alignment: .topTrailing)
                            Cloud(proxy: geometry,
                                  color: Theme.ellipsesBottomLeading(forScheme: scheme),
                                  rotationStart: 120,
                                  duration: 80,
                                  alignment: .bottomLeading)
                            Cloud(proxy: geometry,
                                  color: Theme.ellipsesTopLeading(forScheme: scheme),
                                  rotationStart: 180,
                                  duration: 70,
                                  alignment: .topLeading)
                        }
                        .blur(radius: blur)
                    }
                    .ignoresSafeArea()
                )
                .overlay(
                        Button {
                            if isDarkMode == 0 {
                                isDarkMode = 1
                            } else {
                                isDarkMode = 0
                            }
                        } label: {
                            Image(systemName: isDarkMode == 0 ? "moon" : "sun.max")
                                .frame(width: 64, height: 64)
                                .font(.title)
                                .fontWeight(.bold)
                                .background(isDarkMode == 0 ? .black : .white)
                                .foregroundColor(isDarkMode == 0 ? .white : .black)
                                .cornerRadius(16)
                        }
                        .buttonStyle(.plain)
                        .padding([.bottom, .leading])
                    
                    ,alignment: .bottomLeading
                )
            }
        }
    }
    
    @ViewBuilder
    func accountInfoCard() -> some View {
        GeometryReader { cardGeometry in
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
                                withAnimation {
                                    authViewModel.signOut()
                                    isLoggedIn = false
                                    exitedSignIn = false
                                }
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
                    
//                    Text("By proceeding you accept our **Terms of Service** and **Privacy Policy**")
//                        .font(.footnote)
                    
                    Button {
                        if userProfile.email.contains(".ssts.edu.sg") || userProfile.email.contains("sst.edu.sg") {
                            withAnimation {
                                exitedSignIn = true
                            }
                            
                            if userProfile.email.contains(".ssts.edu.sg") {
                                checkSecondaryLevel()
                            } else {
                                secondaryLevel = 0
                            }
                            
                        }
                    } label: {
                        if !userProfile.email.contains(".ssts.edu.sg") && !userProfile.email.contains("sst.edu.sg") {
                            Text("Please log in using your **SST Email Address.**")
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                                .padding(.bottom, 8)
                        } else {
                            HStack {
                                Text("Proceed to QuizX")
                                Image(systemName: "arrow.right")
                            }
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                                .padding(.bottom, 8)
                        }
                    }
                    .buttonStyle(.plain)
                    .disabled(!userProfile.email.contains("ssts.edu.sg") && !userProfile.email.contains("sst.edu.sg"))
                    
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .foregroundColor(Color.primary.opacity(0.8))
            .foregroundStyle(.ultraThinMaterial)
            .cornerRadius(35)
            .padding()
            .padding(.vertical, 10)
            .frame(width: cardGeometry.size.width / 2)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    
    func checkSecondaryLevel() {
        if let userProfile = user?.profile {
            let emailCharArray = Array(userProfile.email) // converts string of email address into array of characters
            
            let firstEmailDomainPosition = emailCharArray.firstIndex(of: "@")! + 1 // gets position of @ symbol + 1 (output: s2021.ssts.edu.sg)
            
            let arrayOfEmailDomain = emailCharArray[firstEmailDomainPosition...firstEmailDomainPosition + 4] // gets first 5 characters (output: s2021)
            
            var emailDomain: String = "" // initialises emailDomain var for emailDomain (emailDomain = s2021 etc.)
            
            arrayOfEmailDomain.forEach { character in
                emailDomain = String(emailDomain) + String(character) // adds characters together to form a string
            }
            
            emailDomain.remove(at: emailDomain.startIndex) // removes "s" in s2021
            
            let yearJoinedSST = Int(emailDomain)! // turns string 2021 into int 2021
            
            // gets current year
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            let year = Int(dateFormatter.string(from: date))!
            
            let yearLevel = ((yearJoinedSST - year) * -1) + 1 // gets secondary level
            
            secondaryLevel = yearLevel // sets @appstorage secondaryLevel to yearLevel
        }
    }
}
