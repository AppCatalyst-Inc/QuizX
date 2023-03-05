//
//  subjectSquareCard.swift
//  MathX-macOS
//
//  Created by Tristan on 03/03/2023.
//

import SwiftUI

struct subjectSquareCard: View {
    let square: Square
    let cardWidth: CGFloat
    
    @State var hovering = Bool()
    
    @Environment(\.colorScheme) var colorScheme
    
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                shortcutButton(buttonTitle: "Quizzes", imageName: "doc.richtext", animationid: "quizzesAnimation")
                    .padding(.leading, 10)
                    .onTapGesture {
                        print("\(square.title) - quizzes tapped")
                        // code to be executed when button is pressed
                    }
                
                shortcutButton(buttonTitle: "Notes", imageName: "doc.text", animationid: "notesAnimation")
                    .padding(.trailing, 10)
                    .onTapGesture {
                        print("\(square.title) - notes tapped")
                        // code to be executed when button is pressed
                    }
            }
            
            Spacer()
            
            Divider()
            
            HStack {
                VStack(alignment:.leading) {
                    Text("PLACEHOLDER") // placeholder text idk what to put
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                    HStack {
                        Text(square.title) // subject square title
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        // adds .fill to subject square image unless subject's sf symbol doesnt support it
                        if hovering && square.imageName != "sum" && square.imageName != "function" && square.imageName != "atom" && square.imageName != "character.book.closed.zh" {
                            withAnimation {
                                Image(systemName: square.imageName + ".fill")
                                    .font(.title)
                            }
                        } else if hovering && square.imageName == "character.book.closed.zh" {
                            withAnimation {
                                Image(systemName: "character.book.closed.fill.zh")
                                    .font(.title)
                            }
                        } else {
                            withAnimation {
                                Image(systemName: square.imageName)
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
        .frame(width: cardWidth, height: cardWidth)
        .padding(.vertical)
        .background(square.colour.opacity(colorScheme == .dark ? 0.5 : 0.7))
        .cornerRadius(32)
        .scaleEffect(hovering ? 1.03 : 1)
        .onHover { hover in
            withAnimation(.spring(response: 0.3)) {
                hovering = hover
            }
        }
        .padding(.horizontal, hovering ? 15 : 0)
    }
    
    @ViewBuilder
    func shortcutButton(buttonTitle: String, imageName: String, animationid: String) -> some View {
        VStack {
            Text("") // need a placeholder for button's background
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(colorScheme == .dark ? square.colour.opacity(0.3) : .white) // shortcut button's bg colour
                .cornerRadius(16)
                .overlay (
                    ZStack {
                        square.colour.opacity(colorScheme == .dark ? 0 : 0.65) // shortcut button's bg colour
                            .cornerRadius(16)
                        VStack {
                            Image(systemName: imageName) // shortcut button sf symbol
                                .font(.title)
                            if hovering {
                                withAnimation {
                                    Text(buttonTitle) // shortcut button title
                                        .multilineTextAlignment(.center)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .matchedGeometryEffect(id: animationid, in: animation)
                                }
                            }
                        }
                    }
                    , alignment: .center
                )
        }
        .padding(.horizontal, 2.5)
    }
}

struct subjectSquareCard_Previews: PreviewProvider {
    static var previews: some View {
        Text("subjectSquareCard()")
    }
}
