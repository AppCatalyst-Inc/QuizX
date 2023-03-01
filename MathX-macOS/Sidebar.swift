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
    @Environment(\.colorScheme) var colorScheme
    
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                ForEach(tabs, id: \.self) { image in
                    MenuButton(image: image)
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
        Image(systemName: image)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .scaleEffect(currentTab == image ? 1.1 : 1)
            .foregroundColor(currentTab == image ? .primary : .gray)
            .frame(width: 22, height: 22)
            .frame(width: 96, height: 70)
            .overlay(
                HStack {
                    if currentTab == image {
                        Capsule()
                            .fill(Color.primary)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .frame(width: 3, height: 50)
                            .offset(x: 2)
                    }
                }
                
                ,alignment: .trailing
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring()) {
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
