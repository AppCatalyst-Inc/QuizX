//
//  ContentView.swift
//  MathX-macOS
//
//  Created by Tristan on 27/02/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var quizStore = QuizStore()
    @State private var selectedQuiz: Quiz?
    
    @Binding var pinSidebar: Bool
    @Binding var showSidebar: Bool
    
    @State var currentTab: String = "person"
        
    var body: some View {
        ZStack(alignment: .leading) {
            Color("BG") // sets background to dark gray colour
            
            HStack {
                VStack(alignment: .leading) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        Sidebar(currentTab: $currentTab, showSidebar: $showSidebar, pinSidebar: $pinSidebar)
                            .frame(width: showSidebar ? 100 : 0)
                            .offset(x: showSidebar ? 0 : -100) // hides sidebar
                    }
                }
                
                // current view opened
                if currentTab == "person" {
                    QuizListView(quizzes: quizStore.quizzes) { quiz in
                        selectedQuiz = quiz
                    }
                } else if currentTab == "pencil.and.ruler" {
                    TeacherView(quizStore: quizStore)
                } else if currentTab == "gearshape" {
                    HStack {
                        Spacer()
                        Text("Settings/Profile View")
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        Text("A problem has occurred, Quit and Reopen the app.")
                        Spacer()
                    }
                }
            }
        }
        .frame(minWidth: 800, minHeight: 600) // sets min width and height constraints for app window
        .overlay( // lets us detect whether the mouse is hovering over the far left side of the window
            EmptyView()
                .frame(width: 10)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(.clear)
                .allowsHitTesting(true)
                .onHover { hover in
                    if hover == true && showSidebar == false && pinSidebar == false {
                        withAnimation {
                            showSidebar = hover
                        }
                    }
                }
                .ignoresSafeArea()

            , alignment: .leading
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ContentView")
    }
}
