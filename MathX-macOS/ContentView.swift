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
                if currentTab == "pencil.and.ruler" {
                    CreateQuizView()
                } else if currentTab == "doc.text.image" {
                    NotesView()
                } else if currentTab == "gearshape" {
                    SettingsView()
                } else if currentTab == "square.split.bottomrightquarter" {
                    SquaresView(textfieldFocus: textfieldFocus)
                } else if currentTab == "camera.shutter.button" {
                    ImagePicker()
                } else {
                    HStack {
                        Spacer()
                        Text("A problem has occurred, Quit and Reopen the app.") // appears when @State var currentTab isnt any of the available tabs
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ContentView")
    }
}
