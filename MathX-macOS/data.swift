//
//  data.swift
//  MathX-macOS
//
//  Created by Tristan on 03/03/2023.
//

import Foundation
import SwiftUI

struct Square {
    let title: String
    let imageName: String
    let colour: Color
}

let sqauresCards: [Square] = [
    Square(title: "English", imageName: "books.vertical", colour: .blue),
    Square(title: "EMath", imageName: "sum", colour: .yellow),
    Square(title: "AMath", imageName: "function", colour: .orange),
    Square(title: "Physics", imageName: "tree", colour: .purple),
    Square(title: "Chemistry", imageName: "atom", colour: .green),
    Square(title: "Biology", imageName: "allergens", colour: .cyan),
    Square(title: "Computing", imageName: "terminal", colour: .brown),
    Square(title: "Electronics", imageName: "bolt", colour: .red),
    Square(title: "Biotechnology", imageName: "pills", colour: .green),
    Square(title: "Design Studies", imageName: "paintbrush.pointed", colour: .pink),
    Square(title: "Chinese", imageName: "character.book.closed.zh", colour: .red),
    Square(title: "Social Studies", imageName: "person.line.dotted.person", colour: .indigo),
    Square(title: "Geography", imageName: "mountain.2", colour: .mint),
    Square(title: "History", imageName: "globe.asia.australia", colour: .teal),
    Square(title: "CCE", imageName: "building.2", colour: .gray),
]
