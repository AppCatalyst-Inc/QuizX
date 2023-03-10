import SwiftUI

struct createSquareCard: View {
    
    let cardWidth: CGFloat
    
    @State var hovering = Bool()
    
    var body: some View  {
        VStack {
            Image(systemName: hovering ? "plus.square.fill.on.square.fill" : "plus.square.on.square")
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
                    Text("Click to create a new Square")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                    HStack {
                        Text("Create Square")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        Image(systemName: hovering ? "plus.square.fill.on.square.fill" : "plus.square.on.square")
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
        .cornerRadius(32)
        .scaleEffect(hovering ? 1.03 : 1)
        .onHover { hover in
            withAnimation(.spring(response: 0.3)) {
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


struct createSquareCard_Previews: PreviewProvider {
    static var previews: some View {
        Text("createSquareCard()")
    }
}
