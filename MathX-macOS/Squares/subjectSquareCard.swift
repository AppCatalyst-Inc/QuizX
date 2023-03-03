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
                .background(square.colour.opacity(0.3))
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
                .background(square.colour.opacity(0.3))
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
                        Text(square.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
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
        .frame(width: cardWidth, height: cardWidth, alignment: .center)
        .padding(.vertical)
        .background(square.colour.opacity(0.5))
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

struct subjectSquareCard_Previews: PreviewProvider {
    static var previews: some View {
        Text("subjectSquareCard()")
    }
}
