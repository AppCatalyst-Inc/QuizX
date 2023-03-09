import SwiftUI
import PDFKit

struct NotesView: View {
    @State var pdfDocument: PDFDocument?

    var body: some View {
        VStack {
            if let pdfDocument = pdfDocument {
                PDFKitView(pdfDocument: pdfDocument)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    ProgressView()
                        .font(.title3)
                    Text("Loading PDF...")
                        .font(.title)
                        .padding(.top)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .fontWeight(.bold)
            }
        }
        .onAppear {
            if let url = Bundle.main.url(forResource: "sample", withExtension: "pdf") {
                pdfDocument = PDFDocument(url: url)
            }
        }
    }
}

struct PDFKitView: NSViewRepresentable {
    typealias NSViewType = PDFView

    let pdfDocument: PDFDocument

    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = pdfDocument
        return pdfView
    }

    func updateNSView(_ nsView: PDFView, context: Context) {
        nsView.document = pdfDocument
    }
}

