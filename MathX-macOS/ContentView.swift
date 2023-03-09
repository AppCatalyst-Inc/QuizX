//
//  ContentView.swift
//  MathX-macOS
//
//  Created by Tristan on 27/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTab: String
    @State var textfieldFocus: FocusState<Bool>.Binding

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
                    settingsView()
                } else if currentTab == "square.split.bottomrightquarter" {
                    SquaresView(textfieldFocus: textfieldFocus)
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
