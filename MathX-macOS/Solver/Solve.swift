import SwiftUI
import TesseractOCR
//idk how to import

struct ContentView: View {
    @State private var recognizedText = ""

    var body: some View {
        VStack {
            if !recognizedText.isEmpty {
                Text("Recognized Text:")
                    .font(.headline)
                Text(recognizedText)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }

            Button("Select Image") {
                selectImage()
            }
        }
    }

    private func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        UIApplication.shared.windows.first?.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }

    private func recognizeText(from image: UIImage) {
        let tesseract = G8Tesseract(language: "eng")
        tesseract?.image = image.g8_blackAndWhite()
        tesseract?.recognize()
        recognizedText = tesseract?.recognizedText ?? ""
    }
}

extension ContentView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            recognizeText(from: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
