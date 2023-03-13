import SwiftUI
import Foundation

struct Square {
    let title: String
    let imageName: String
    let colour: Color
}

// subject squares data
let sqauresCardsTotal: [Square] = [
    Square(title: "English", imageName: "books.vertical", colour: .blue),
    Square(title: "Mother Tongue", imageName: "character.book.closed.zh", colour: .red),
    Square(title: "Geography", imageName: "mountain.2", colour: .mint),
    Square(title: "History", imageName: "globe.asia.australia", colour: .teal),
    Square(title: "CCE", imageName: "building.2", colour: .gray),
    
    Square(title: "Math", imageName: "sum", colour: .yellow),
    Square(title: "Science", imageName: "atom", colour: .green),
    Square(title: "ADMT", imageName: "paintbrush.pointed", colour: .pink),
    Square(title: "ICT", imageName: "terminal", colour: .brown),
    Square(title: "I&E", imageName: "doc.append", colour: .blue),
    
    Square(title: "EMath", imageName: "sum", colour: .yellow),
    Square(title: "AMath", imageName: "function", colour: .orange),
    Square(title: "Physics", imageName: "tree", colour: .purple),
    Square(title: "Chemistry", imageName: "atom", colour: .green),
    Square(title: "Biology", imageName: "allergens", colour: .cyan),
    Square(title: "Computing", imageName: "terminal", colour: .brown),
    Square(title: "Electronics", imageName: "bolt", colour: .red),
    Square(title: "Biotechnology", imageName: "pills", colour: .green),
    Square(title: "Design Studies", imageName: "paintbrush.pointed", colour: .pink),
    Square(title: "Social Studies", imageName: "person.line.dotted.person", colour: .indigo),
]

let sqauresCardsLower: [Square] = [
    Square(title: "English", imageName: "books.vertical", colour: .blue),
    Square(title: "Mother Tongue", imageName: "character.book.closed.zh", colour: .red),
    Square(title: "Geography", imageName: "mountain.2", colour: .mint),
    Square(title: "History", imageName: "globe.asia.australia", colour: .teal),
    Square(title: "CCE", imageName: "building.2", colour: .gray),
    
    Square(title: "Math", imageName: "sum", colour: .yellow),
    Square(title: "Science", imageName: "atom", colour: .green),
    Square(title: "ADMT", imageName: "paintbrush.pointed", colour: .pink),
    Square(title: "ICT", imageName: "terminal", colour: .brown),
    Square(title: "I&E", imageName: "doc.append", colour: .blue),
]

let sqauresCardsUpper: [Square] = [
    Square(title: "English", imageName: "books.vertical", colour: .blue),
    Square(title: "Mother Tongue", imageName: "character.book.closed.zh", colour: .red),
    Square(title: "Geography", imageName: "mountain.2", colour: .mint),
    Square(title: "History", imageName: "globe.asia.australia", colour: .teal),
    Square(title: "CCE", imageName: "building.2", colour: .gray),
    
    Square(title: "EMath", imageName: "sum", colour: .yellow),
    Square(title: "AMath", imageName: "function", colour: .orange),
    Square(title: "Physics", imageName: "tree", colour: .purple),
    Square(title: "Chemistry", imageName: "atom", colour: .green),
    Square(title: "Biology", imageName: "allergens", colour: .cyan),
    Square(title: "Computing", imageName: "terminal", colour: .brown),
    Square(title: "Electronics", imageName: "bolt", colour: .red),
    Square(title: "Biotechnology", imageName: "pills", colour: .green),
    Square(title: "Design Studies", imageName: "paintbrush.pointed", colour: .pink),
    Square(title: "Social Studies", imageName: "person.line.dotted.person", colour: .indigo),
]
