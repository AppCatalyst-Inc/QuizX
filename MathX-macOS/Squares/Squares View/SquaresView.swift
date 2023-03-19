import SwiftUI

struct SquaresView: View {
    
    let geometry: GeometryProxy
    
    let cardWidth = CGFloat(285)
    
    @State var search = String()
        
    @State var textfieldFocus: FocusState<Bool>.Binding

    @State var squaresCards = [Square]()
    
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("secondaryLevel", store: .standard) var secondaryLevel = Int()
        
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Squares") // title
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.vertical, 30)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        searchBar // search bar
                            .padding(.trailing, 10)
                    }
                    
                    // squares layout
                    GeometryReader { geometry in
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: Int(floor((geometry.size.width - 70) / cardWidth))), spacing: 30) {
                                ForEach(searchResults, id: \.title) { square in
                                    subjectSquareCard(square: square, geometry: geometry, cardWidth: cardWidth)
                                        .padding(.horizontal)
                                }
                            }
                            .padding()
                            
                            /*
                            if search.isEmpty {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: Int(floor((geometry.size.width - 70) / cardWidth))), spacing: 30) {
                                    joinSquareCard(cardWidth: cardWidth)
                                        .frame(width: cardWidth, height: cardWidth)
                                        .padding()
                                        .onTapGesture {
                                            print("joinSquare tapped")
                                             //code to be executed when button is pressed
                                        }
                                    
                                    createSquareCard(cardWidth: cardWidth)
                                        .frame(width: cardWidth, height: cardWidth)
                                        .padding()
                                        .onTapGesture {
                                            print("createSquare tapped")
                                             //code to be executed when button is pressed
                                        }
                                }
                                .padding()
                                .padding(.bottom, 100) // add this if adding join and create squares buttons view
                            }
                            */
                            
                            .padding(.bottom, 100) // remove this if adding join and create squares buttons view
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            squaresCards = secondaryLevel == 0 ? sqauresCardsTotal : secondaryLevel > 2 ? sqauresCardsUpper : sqauresCardsLower
        }
    }
    
    var searchResults: [Square] {
        if search.isEmpty {
            return squaresCards
        } else {
            return squaresCards.filter { $0.title.uppercased().starts(with: search.uppercased()) }
        }
    }
    
    var searchBar: some View {
        HStack(spacing: 10) {
            if search.isEmpty {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .padding([.top, .leading], 0.5) // to counter xmark's slightly larger sf symbol
                    .onTapGesture {
                        textfieldFocus.wrappedValue.toggle() // focuses search field when magnifying glass is pressed
                    }
            } else {
                    Button {
                        search = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
            }
            
            TextField("Search", text: $search)
                .frame(width: 150)
                .textFieldStyle(.plain)
                .foregroundColor(.gray)
                .font(.headline)
                .fontWeight(.bold)
                .focused(textfieldFocus)
                .onExitCommand {
                    textfieldFocus.wrappedValue = false // unfocuses search field when escape key is pressed
                }
                .onSubmit {
                    textfieldFocus.wrappedValue = false // unfocuses search field when enter key is pressed
                }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color("inverseBG"))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(colorScheme == .dark ? .gray : .clear, lineWidth: 1.5) // sets border width around search bar if in dark mode
        )
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.2), radius: 5, x: 5, y: 0) // sets shadow below search bar if in light mode
    }
}

struct SquaresView_Previews: PreviewProvider {
    static var previews: some View {
        Text("SquaresView()")
    }
}
