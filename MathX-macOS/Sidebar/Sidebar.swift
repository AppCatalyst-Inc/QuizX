import SwiftUI

struct Sidebar: View {
    
    @Binding var currentTab: String
    
    @State var tabs: Array = ["square.split.bottomrightquarter", "pencil.and.ruler", "gearshape", "doc.text.image"]
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
                                // sets menubutton image to its corresponding image
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
            // width and height of sidebar
            .frame(width: 100)
            .frame(maxHeight: .infinity, alignment: .top)
            .background( // sidebar rounding (top right and bottom right)
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
                .scaleEffect(currentTab == image ? 1.2 : 1)  // scales icon of selected tab
                .foregroundColor(currentTab == image ? .primary : .gray)
                .frame(width: 22, height: 22) // width and height of menu button
            
            // adds text to icons when hovered over
            if !hoverImage.isEmpty {
                if image == "pencil.and.ruler" || image == "pencil.and.ruler.fill" {
                    if hoverImage == "pencil.and.ruler" || hoverImage == "pencil.and.ruler.fill" {
                        withAnimation {
                            sidebarHoverText(hoverText: "Create Quiz")
                        }
                    }
                } else if image == "gearshape" || image == "gearshape.fill" {
                    if hoverImage == "gearshape" || hoverImage == "gearshape.fill" {
                        withAnimation {
                            sidebarHoverText(hoverText: "Settings")
                        }
                    }
                } else if image == "square.split.bottomrightquarter" || image == "square.split.bottomrightquarter.fill" {
                    if hoverImage == "square.split.bottomrightquarter" || hoverImage == "square.split.bottomrightquarter.fill" {
                        withAnimation {
                            sidebarHoverText(hoverText: "Squares")
                        }
                    }
                } else if image == "doc.text.image" || image == "doc.text.image.fill" {
                    if hoverImage == "doc.text.image" || hoverImage == "doc.text.image.fill" {
                        withAnimation {
                            sidebarHoverText(hoverText: "Notes")
                        }
                    }
                }
            }
        }
        .frame(width: 96, height: 96) // width and height of usable sidebar space
        .overlay(
            HStack {
                if image == hoverImage { // light gray background hovering effect
                    withAnimation {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(colorScheme == .dark ? Color.primary.opacity(0.2) : Color.gray.opacity(0.2))
                            .matchedGeometryEffect(id: "hover", in: animation)
                            .frame(width: image == currentTab ? 86 : 88, height: image == hoverImage ? 80 : 0)
                            .offset(x: image == currentTab ? 4 : 0)
                    }
                }
            }
            , alignment: image == currentTab ? .leading : .center
        )
        .overlay( // capsule-line indicator to show current tab
            HStack {
                if currentTab == image {
                    withAnimation {
                        Capsule()
                            .fill(Color.primary)
                            .matchedGeometryEffect(id: "tab", in: animation)
                            .frame(width: 3, height: 80)
                            .offset(x: 2)
                    }
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
    
    @ViewBuilder
    func sidebarHoverText(hoverText: String) -> some View {
        VStack {
            Text(hoverText)
                .padding(.horizontal, 6)
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Text("Sidebar View")
    }
}
