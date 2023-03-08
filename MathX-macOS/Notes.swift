//
//  Notes.swift
//  MathX-macOS
//
//  Created by AathithyaJ on 8/3/23.
//

import SwiftUI
import PDFKit

struct PDFView: UIViewRepresentable {
    var pdfURL: URL
    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        pdfView.document = PDFDocument(url: pdfURL)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFKit.PDFView, context: Context) {
        uiView.document = PDFDocument(url: pdfURL)
    }
}

struct ContentView: View {
    @State private var pdfData: Data? = nil
    
    var body: some View {
        VStack {
            if let pdfData = pdfData {
                PDFKitView(pdfData: pdfData)
            } else {
                Text("Loading PDF...")
            }
        }
        .onAppear {
            guard let url = URL(string: "https://www.example.com/example.pdf") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.pdfData = data
                }
            }.resume()
        }
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView()
    }
}

