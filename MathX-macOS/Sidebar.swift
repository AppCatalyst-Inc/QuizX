//
//  Sidebar.swift
//  MathX-macOS
//
//  Created by Tristan on 28/02/2023.
//

import SwiftUI

struct Sidebar: View {
    
    @Binding var showingAnswerView: Bool
    @Binding var showingTeacherView: Bool
    @Binding var showingView3: Bool

    var body: some View {
        VStack {
            Spacer()
            Button {
                showingAnswerView = true
                showingTeacherView = false
                showingView3 = false
            } label: {
                sidebarButtonView(title: "Student View", image: "person", viewFocused: $showingAnswerView)
            }
            .buttonStyle(.plain)
                 
            Button {
                showingAnswerView = false
                showingTeacherView = true
                showingView3 = false
            } label: {
                sidebarButtonView(title: "Teacher View", image: "pencil.and.ruler", viewFocused: $showingTeacherView)
            }
            .buttonStyle(.plain)
            
            Button {
                showingAnswerView = false
                showingTeacherView = false
                showingView3 = true
            } label: {
                sidebarButtonView(title: "View 3", image: "3.circle", viewFocused: $showingView3)
            }
            .buttonStyle(.plain)

            Spacer()
        }
        .frame(width: 150)
        .background(.background)
        .cornerRadius(20)
    }
}

struct sidebarButtonView: View {
    let title: String
    let image: String
    @Binding var viewFocused: Bool
    
    @State private var hovering = Bool()
    
    var body: some View {
        Group {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(title)
            }
        }
        .frame(width: 110, height: 110)
        .background(hovering ? .secondary.opacity(0.4) : Color.clear)
        .background(viewFocused ? .secondary.opacity(0.1) : Color.clear)
        .cornerRadius(20)
        .onHover { hoverStatus in
            hovering = hoverStatus
        }
        .padding(.vertical, 5)
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Text("Sidebar View")
    }
}
