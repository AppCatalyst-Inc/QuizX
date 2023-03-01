//
//  Sidebar.swift
//  MathX-macOS
//
//  Created by Tristan on 01/03/2023.
//

import SwiftUI

struct Sidebar: View {
    
    @Binding var currentTab: String
    @State var tabs: Array = ["person", "pencil.and.ruler", "gearshape"]
    @State var hoverImage = ""
    @Environment(\.colorScheme) var colorScheme
    
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                ForEach(tabs, id: \.self) { image in
                    MenuButton(image: image)
                        .onHover { state in
                            withAnimation(.spring(response: 0.2)) {
                                if state {
                                    hoverImage = image
                                } else {
                                    hoverImage = ""
                                }
                            }
                        }
                }
                Spacer()
            }
            .frame(width: 100)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(
                ZStack {
                    Color(NSColor.windowBackgroundColor)
                        .padding(.trailing, 30)
                    
                    Color(NSColor.windowBackgroundColor)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.2), radius: 5, x: 5, y: 0)
                }
                    .ignoresSafeArea()
            )
            
            
        }
    }
    
    @ViewBuilder
    func MenuButton(image: String) -> some View {
        VStack {
            Image(systemName: currentTab == image ? image + ".fill" : image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .scaleEffect(currentTab == image ? 1.2 : 1)
                .foregroundColor(currentTab == image ? .primary : .gray)
                .frame(width: 22, height: 22)
            if !hoverImage.isEmpty {
                if image == "person" || image == "person.fill" {
                    if hoverImage == "person" || hoverImage == "person.fill" {
                        withAnimation {
                            Text("Quizzes")
                                .padding(.horizontal, 6)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                    }
                } else if image == "pencil.and.ruler" || image == "pencil.and.ruler.fill" {
                    if hoverImage == "pencil.and.ruler" || hoverImage == "pencil.and.ruler.fill" {
                        withAnimation {
                            Text("Create Quiz")
                                .padding(.horizontal, 6)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                    }
                } else if image == "gearshape" || image == "gearshape.fill" {
                    if hoverImage == "gearshape" || hoverImage == "gearshape.fill" {
                        withAnimation {
                            Text("Settings")
                                .padding(.horizontal, 6)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
            .frame(width: 96, height: 96)
            .overlay(
                HStack {
                    if image == hoverImage {
                        withAnimation {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.primary.opacity(0.2))
                                .matchedGeometryEffect(id: "Hover", in: animation)
                                .frame(width: image == currentTab ? 86 : 88, height: image == hoverImage ? 80 : 0)
                                .offset(x: image == currentTab ? 4 : 0)
                        }
                    }
                }
                , alignment: image == currentTab ? .leading : .center
            )
            .overlay(
                HStack {
                    if currentTab == image {
                        Capsule()
                            .fill(Color.primary)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                            .frame(width: 3, height: 80)
                            .offset(x: 2)
                    }
                }
                
                , alignment: .trailing
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.5)) {
                    currentTab = image
                }
            }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Text("Sidebar View")
    }
}

extension View {
    func getRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
}
