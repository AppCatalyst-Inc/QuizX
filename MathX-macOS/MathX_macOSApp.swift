import SwiftUI
import GoogleSignIn

@main
struct MathX_macOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @FocusState var textfieldFocus
    
    @State var currentTab: String = "square.split.bottomrightquarter"
    
    @AppStorage("exitedSignIn", store: .standard) var exitedSignIn = false
    @AppStorage("isLoggedIn", store: .standard) var isLoggedIn = false
    @AppStorage("isDarkMode") var isDarkMode = 1
    
    @StateObject var authViewModel = AuthenticationViewModel()
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    let transition = AnyTransition.asymmetric(insertion: .slide, removal: .scale).combined(with: .opacity)
    
    var body: some Scene {
        WindowGroup {
            if exitedSignIn {
                ContentView(currentTab: currentTab, textfieldFocus: $textfieldFocus)
                    .background(Color("BG").ignoresSafeArea()) // sets bg colour to cover title bar / toolbar too
                    .frame(minWidth: 1000, minHeight: 800) // sets min width and height constraints for app window
                    .environmentObject(authViewModel)
                    .onAppear {
                        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                            if let user = user {
                                self.authViewModel.state = .signedIn(user)
                            } else if let error = error {
                                withAnimation {
                                    self.authViewModel.state = .signedOut
                                    isLoggedIn = false
                                    exitedSignIn = false
                                }
                                print("There was an error restoring the previous sign-in: \(error)")
                            } else {
                                withAnimation {
                                    self.authViewModel.state = .signedOut
                                    isLoggedIn = false
                                    exitedSignIn = false
                                }
                            }
                        }
                    }
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                    }
                    .preferredColorScheme(isDarkMode == 0 ? .dark : .light)
            } else {
                AuthView()
                    .background(Color("BG").ignoresSafeArea()) // sets bg colour to cover title bar / toolbar too
                    .frame(minWidth: 1000, minHeight: 800) // sets min width and height constraints for app window
                    .environmentObject(authViewModel)
                    .onAppear {
                        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                            if let user = user {
                                self.authViewModel.state = .signedIn(user)
                            } else if let error = error {
                                withAnimation {
                                    self.authViewModel.state = .signedOut
                                    isLoggedIn = false
                                    exitedSignIn = false
                                }
                                print("There was an error restoring the previous sign-in: \(error)")
                            } else {
                                withAnimation {
                                    self.authViewModel.state = .signedOut
                                    isLoggedIn = false
                                    exitedSignIn = false
                                }
                            }
                        }
                    }
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                    }
                    .preferredColorScheme(isDarkMode == 0 ? .dark : .light)
            }
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) { // removes option to add new windows with command N or through menu bar
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    private func applicationDidFinishLaunching(_ notification: Notification) {
        
    }
}
