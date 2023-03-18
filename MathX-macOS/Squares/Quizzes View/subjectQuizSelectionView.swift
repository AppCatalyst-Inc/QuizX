import SwiftUI

struct subjectQuizSelectionView: View {
    
    let subject: Square
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    
                    // Toolbar
                    HStack {
                        Text(subject.title) // title
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .padding(.vertical, 30)
                        
                        Image(systemName: subject.imageName)
                            .font(.title)
                        
                        Spacer()
                        
                        Button { // dismiss button
                            withAnimation(.spring(response: 1, dampingFraction: 1)) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                                .padding(10)
                                .background(.ultraThickMaterial)
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .padding(.trailing, 10)
                    }
                    .padding(.top)
                    
                    Text("lorem ipsum")
                    // quizzes go here
                }
                
                Spacer()
            }
        }
        .padding(.leading, 10)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(subject.colour.opacity(colorScheme == .dark ? 0.5 : 0.7))
    }
}

