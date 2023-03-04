//
//  SquaresView.swift
//  MathX-macOS
//
//  Created by Tristan on 02/03/2023.
//

import SwiftUI

struct SquaresView: View {
    
    let cardWidth = CGFloat(285)
    
    @State var search = String()
        
    @State var textfieldFocus: FocusState<Bool>.Binding
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Squares") // title
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.vertical, 30)
                        
                        Spacer()
                        
                        searchBar // search bar
                    }
                    
                    // squares layout
                    GeometryReader { geometry in
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: Int(floor((geometry.size.width - 70) / cardWidth))), spacing: 30) {
                                ForEach(searchResults, id: \.title) { square in
                                    subjectSquareCard(square: square, cardWidth: cardWidth)
                                        .padding(.horizontal)
                                }
                            }
                            .padding()
                            
                            if search.isEmpty {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: Int(floor((geometry.size.width - 70) / cardWidth))), spacing: 30) {
                                    Button {
                                        
                                    } label: {
                                        joinSquareCard(cardWidth: cardWidth)
                                    }
                                    .frame(width: cardWidth, height: cardWidth)
                                    .padding()
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        
                                    } label: {
                                        createSquareCard(cardWidth: cardWidth)
                                    }
                                    .frame(width: cardWidth, height: cardWidth)
                                    .padding()
                                    .buttonStyle(.plain)
                                }
                                .padding()
                                .padding(.bottom, 100)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    var searchResults: [Square] {
        if search.isEmpty {
            return sqauresCards
        } else {
            return sqauresCards.filter { $0.title.uppercased().starts(with: search.uppercased()) }
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
            
            TextField("Search", text: $search)
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

struct SquaresView_Previews: PreviewProvider {
    static var previews: some View {
        Text("SquaresView()")
    }
}
