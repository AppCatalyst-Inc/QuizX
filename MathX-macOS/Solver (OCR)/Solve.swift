import SwiftUI
import Cocoa
import Vision

struct ImagePicker: View {
    @State private var selectedImage: NSImage?
    @State private var recognizedText: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No image selected")
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    selectedImage = nil
                    recognizedText = ""
                }) {
                    Text("Clear")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    let dialog = NSOpenPanel()
                    dialog.allowedContentTypes = [.jpeg, .png, .gif, .image]
                    
                    if dialog.runModal() == NSApplication.ModalResponse.OK {
                        if let url = dialog.url {
                            selectedImage = NSImage(contentsOf: url)
                        }
                    }
                }) {
                    Text("Select Image")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    if let image = selectedImage, let imageData = image.tiffRepresentation {
                        let requestHandler = VNImageRequestHandler(data: imageData, options: [:])
                        let request = VNRecognizeTextRequest { request, error in
                            guard let observations = request.results as? [VNRecognizedTextObservation],
                                  error == nil else {
                                self.recognizedText = "Error recognizing text"
                                return
                            }
                            
                            var recognizedText = ""
                            
                            for observation in observations {
                                guard let topCandidate = observation.topCandidates(1).first else {
                                    continue
                                }
                                recognizedText += "\(topCandidate.string) "
                            }
                            
                            self.recognizedText = recognizedText
                        }
                        
                        do {
                            try requestHandler.perform([request])
                        } catch {
                            self.recognizedText = "Error recognizing text"
                        }
                    } else {
                        self.recognizedText = "No image selected"
                    }
                }) {
                    Text("Recognize Text")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    if self.recognizedText.isEmpty {
                        Text("No text found")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        // Copy recognizedText to clipboard
                        let pasteboard = NSPasteboard.general
                        pasteboard.declareTypes([.string], owner: nil)
                        pasteboard.setString(self.recognizedText, forType: .string)
                        
                        // Show alert
                        self.showingAlert = true
                        
                        // Hide alert after 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showingAlert = false
                        }
                    }
                }) {
                    Text("Copy Text")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Text copied"), dismissButton: .default(Text("OK")))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 20)
            
            Spacer()
            
            HStack {
                Spacer()
                Text(self.recognizedText)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker()
    }
}
