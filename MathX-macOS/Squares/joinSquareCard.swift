//
//  joinSquareCard.swift
//  MathX-macOS
//
//  Created by Tristan on 03/03/2023.
//

import SwiftUI

struct joinSquareCard: View {
    
    let cardWidth: CGFloat
    
    @State var hovering = Bool()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View  {
        VStack {
            Image(systemName: hovering ? "plus.square.fill" : "plus.square")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
                .cornerRadius(16)
                .padding(.horizontal, 1)
                .padding(.horizontal)
            
            Spacer()
            
            Divider()
            
            HStack {
                VStack(alignment:.leading) {
                    Text("Click to join a Square")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                    HStack {
                        Text("Join Square")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        Image(systemName: hovering ? "plus.square.fill" : "plus.square")
                            .font(.title)
                        
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
        .background(.clear)
        .cornerRadius(32)
        .scaleEffect(hovering ? 1.03 : 1)
        .onHover { hover in
            withAnimation(.easeOut) {
                hovering = hover
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 2, dash: [CGFloat(15)]))
                .scaleEffect(hovering ? 1.03 : 1)
            
            , alignment: .center
        )
        .padding(.horizontal, hovering ? 15 : 0)
    }
}


struct joinSquareCard_Previews: PreviewProvider {
    static var previews: some View {
        Text("joinSquareCard()")
    }
}
