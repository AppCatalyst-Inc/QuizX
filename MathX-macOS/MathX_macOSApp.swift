import SwiftUI
import GoogleSignIn

@main
struct MathX_macOSApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @FocusState var textfieldFocus
    
    @State var currentTab: String = "square.split.bottomrightquarter"
    
    @AppStorage("exitedSignIn", store: .standard) var exitedSignIn = false
    @AppStorage("isLoggedIn", store: .standard) var isLoggedIn = false
    @AppStorage("isDarkMode") var isDarkMode = 1
    
    @StateObject var authViewModel = AuthenticationViewModel()
    
    static let screenWidth = NSScreen.main?.visibleFrame.size.width
    static let screenHeight = NSScreen.main?.visibleFrame.size.height
    
    let transition = AnyTransition.asymmetric(insertion: .slide, removal: .scale).combined(with: .opacity)
    
    var body: some Scene {
        WindowGroup {
            if exitedSignIn {
                ContentView(currentTab: currentTab, textfieldFocus: $textfieldFocus)
                    .focusable(false) // disables tab button from selecting items
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
                    .focusable(false) // disables tab button from selecting items
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
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) { // removes option to add new windows with command N or through menu bar
            }
            
            CommandGroup(replacing: .appInfo) {
                Button("About QuizX") {
                    NSApplication.shared.orderFrontStandardAboutPanel(
                        options: [
                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                string: "Developers: Aathithya Jegatheesan, Tristan Chay, Sairam Suresh, and Kavin Jayakumar",
                                attributes: [
                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
                                        ofSize: NSFont.smallSystemFontSize)
                                ]
                            ),
                            NSApplication.AboutPanelOptionKey(
                                rawValue: "Copyright"
                            ): "© 2023 AppCatalyst Inc., a company in SST Inc."
                        ]
                    )
                }
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let _ = NSApplication.shared.windows.map { $0.tabbingMode = .disallowed }
    }
}
