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

    @State var sidebarWidth: CGFloat = 150
    @Binding var isSidebarVisible: Bool
        
    @State var showingAnswerView = true
    @State var showingTeacherView = false
    @State var showingView3 = false
    
    var body: some View {
        ZStack {
            Color(NSColor.windowBackgroundColor)
            
            HStack {
                withAnimation(.easeInOut(duration: 2)) {
                    VStack(alignment: .leading) {
                        Sidebar(showingAnswerView: $showingAnswerView, showingTeacherView: $showingTeacherView, showingView3: $showingView3)
                            .frame(width: isSidebarVisible ? 150 : 0)
                            .offset(x: isSidebarVisible ? 0 : -sidebarWidth)
                            .padding([.vertical, .leading], 5)
                            
                    }
                }
                
                if showingAnswerView {
                    QuizListView(quizzes: quizStore.quizzes) { quiz in
                        selectedQuiz = quiz
                    }
                } else if showingTeacherView {
                    TeacherView(quizStore: quizStore)
                } else if showingView3 {
                    HStack {
                        Spacer()
                        Text("This is View 3")
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
        .frame(minWidth: 800, minHeight: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ContentView")
    }
}
