import SwiftUI
import GoogleSignIn

struct ContentView: View {
    
    @State var currentTab: String
    @State var textfieldFocus: FocusState<Bool>.Binding
    
    @StateObject var authViewModel = AuthenticationViewModel()

    var body: some View {
        ZStack(alignment: .leading) {
            Color("BG") // sets background to dark gray colour
            
            HStack {
                VStack(alignment: .leading) {
                    Sidebar(currentTab: $currentTab)
                }
                
                // current view opened
                if currentTab == "person" {
                    //
                } else if currentTab == "pencil.and.ellipsis.rectangle" {
                    
                } else if currentTab == "pencil.and.ruler" {
                    CreateQuizView()
                } else if currentTab == "doc.text.image" {
                    NotesView()
                } else if currentTab == "gearshape" {
                    SettingsView()
                } else if currentTab == "square.split.bottomrightquarter" {
                    SquaresView(textfieldFocus: textfieldFocus)
                } else if currentTab == "camera.shutter.button" {
                    ImagePicker()
                } else if currentTab == "person.crop.circle.badge.plus" {
                    AuthView()
                      .environmentObject(authViewModel)
                      .onAppear {
                        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                          if let user = user {
                            self.authViewModel.state = .signedIn(user)
                          } else if let error = error {
                            self.authViewModel.state = .signedOut
                            print("There was an error restoring the previous sign-in: \(error)")
                          } else {
                            self.authViewModel.state = .signedOut
                          }
                        }
                      }
                      .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                      }
                } else {
                    HStack {
                        Spacer()
                        Text("A problem has occurred, Quit and Reopen the app.") // appears when @State var currentTab isnt any of the available tabs
                        Spacer()
                    }
                }
            }
        }
        .frame(minWidth: 1000, minHeight: 800) // sets min width and height constraints for app window
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ContentView")
    }
}
