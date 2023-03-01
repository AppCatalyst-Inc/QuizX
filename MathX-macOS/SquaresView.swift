//
//  SquaresView.swift
//  MathX-macOS
//
//  Created by Tristan on 02/03/2023.
//

import SwiftUI

struct SquaresView: View {
    
    let items = ["English", "EMath", "AMath",  "Physics", "Chemistry", "Biology", "Computing", "Electronics","Biotech", "Design Studies", "Chinese", "Social Studies", "Geography", "History", "CCE"]
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Squares")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical, 30)
                    
                    GeometryReader { geometry in
                        let cardWidth = CGFloat((geometry.size.width - 80) / 5)

                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 3), spacing: 16), count: 5), spacing: 16) {
                                ForEach(items, id: \.self) { item in
                                    SquaresCard(title: item, cardWidth: cardWidth)
                                        .padding(.horizontal)
                                }
                            }
                            .padding()
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


struct SquaresCard: View {
    let title: String
    let cardWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.primary)
                .font(.headline)
            Spacer()
        }
        .padding()
        .frame(width: cardWidth, height: cardWidth)
        .background(.thinMaterial)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct SquaresView_Previews: PreviewProvider {
    static var previews: some View {
        SquaresView()
    }
}
