//
//  SquaresView.swift
//  MathX-macOS
//
//  Created by Tristan on 02/03/2023.
//

import SwiftUI

struct SquaresView: View {
    
    let squares = ["English": "books.vertical", "E Math": "sum", "A Math": "function", "Physics": "tree", "Chemistry": "atom", "Biology": "allergens", "Computing": "terminal", "Electronics": "bolt", "Biotech": "pills", "Design Studies": "paintbrush.pointed", "Chinese": "character.book.closed.zh", "Social Studies": "person.line.dotted.person", "Geography": "mountain.2", "History": "globe.asia.australia", "CCE": "building.2"]
    let squaresColour = ["English": .blue, "EMath": .yellow, "AMath": .orange, "Physics": .purple, "Chemistry": .green, "Biology": .cyan, "Computing": .brown, "Electronics": .red, "Biotech": Color.green, "Design Studies": .pink, "Chinese": .red, "Social Studies": Color.indigo, "Geography": Color.mint, "History": Color.teal, "CCE": Color.gray]
    
    @State var searchSquares = String()
        
    @State var textfieldFocus: FocusState<Bool>.Binding
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Squares")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.vertical, 30)
                        
                        Spacer()
                        
                        searchBar
                    }
                    
                    GeometryReader { geometry in
                        let cardWidth = CGFloat((geometry.size.width - 80) / 5)
                        
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 3), spacing: 30), count: 5), spacing: 30) {
                                ForEach(searchSquaresResults.sorted(), id: \.self) { item in
                                    SquaresCard(title: item, image: squares[item]!, cardWidth: cardWidth, colour: squaresColour[item]!)
                                        .padding(.horizontal)
                                }
                            }
                            .padding()
                            .padding(.bottom, 100)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    var searchSquaresResults: [String] {
        if searchSquares.isEmpty {
            return squares.map{$0.key}
        } else {
            return squares.map{$0.key}.filter { $0.uppercased().starts(with: searchSquares.uppercased()) }
        }
    }
    
    var searchBar: some View {
        HStack(spacing: 10) {
            Button {
                textfieldFocus.wrappedValue.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.primary)
            }
            .keyboardShortcut("F", modifiers: [.command, .shift])
            .buttonStyle(.plain)
            
            TextField("Search", text: $searchSquares)
                .frame(width: 150)
                .textFieldStyle(.plain)
                .foregroundColor(.gray)
                .font(.headline)
                .fontWeight(.bold)
                .focused(textfieldFocus)
                .onExitCommand {
                    textfieldFocus.wrappedValue = false
                }
                .onSubmit {
                    textfieldFocus.wrappedValue = false
                }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color("inverseBG"))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(colorScheme == .dark ? .gray : .clear, lineWidth: 1.5)
        )
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.2), radius: 5, x: 5, y: 0)
    }
}


struct SquaresCard: View {
    let title: String
    let image: String
    let cardWidth: CGFloat
    let colour: Color
    
    @State var hovering = Bool()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "qrcode.viewfinder")
                                .font(.title2)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                .background(colour.opacity(0.3))
                .cornerRadius(16)
                .padding(.horizontal, 1)
                
                Button {
                    
                } label: {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "calendar.day.timeline.right")
                                .font(.title2)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                .background(colour.opacity(0.3))
                .cornerRadius(16)
                .padding(.horizontal, 1)
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            Divider()
            
            HStack {
                VStack(alignment:.leading) {
                    Text("PLACEHOLDER")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                    HStack {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        if hovering && image != "sum" && image != "function" && image != "atom" && image != "character.book.closed.zh" {
                            withAnimation {
                                Image(systemName: image + ".fill")
                                    .font(.title)
                            }
                        } else if hovering && image == "character.book.closed.zh" {
                            withAnimation {
                                Image(systemName: "character.book.closed.fill.zh")
                                    .font(.title)
                            }
                        } else {
                            withAnimation {
                                Image(systemName: image)
                                    .font(.title)
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom)
            
        }
        .frame(width: cardWidth, height: cardWidth, alignment: .center)
        .padding(.vertical)
        .background(colour.opacity(0.5))
        .cornerRadius(32)
        .scaleEffect(hovering ? 1.03 : 1)
        .onHover { hover in
            withAnimation(.easeOut) {
                hovering = hover
            }
        }
        .padding(.horizontal, hovering ? 15 : 0)
    }
}

struct SquaresView_Previews: PreviewProvider {
    static var previews: some View {
        Text("SquaresView()")
    }
}
