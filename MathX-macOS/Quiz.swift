import SwiftUI

import SwiftUI

struct CreateQuizView: View {
    @StateObject var quiz = Quiz(title: "", questions: [])
    @State var isTimed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Time Mode")
                    .font(.headline)
                    .fontWeight(.bold)
                Toggle("", isOn: $isTimed)
                    .labelsHidden()
            }
            
            Text("Create a Quiz")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Quiz Title", text: $quiz.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Divider()
            
            List {
                ForEach($quiz.questions) { $question in
                    HStack {
                        TextField("Prompt", text: $question.prompt)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity)
                        
                        if isTimed {
                            TextField("Time (seconds)", text: $question.timer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 100)
                        }
                        
                        TextField("Answer", text: $question.answer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity)
                        
                        Button(action: {
                            if quiz.questions.count > 1, let index = quiz.questions.firstIndex(where: { $0.id == question.id }) {
                                quiz.questions.remove(at: index)
                            }
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Button(action: {
                    quiz.questions.append(Question(prompt: "", answer: "", timer: isTimed ? "25" : ""))
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.green)
                        Text("Add Question")
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            Divider()
            
            HStack {
                Spacer()
                Button(action: saveQuiz) {
                    Text("Save Quiz")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
    }
    
    func saveQuiz() {
        // Save the quiz to the database or wherever it needs to go
        print("Saved")
    }
}

struct Question: Identifiable {
    let id = UUID()
    var prompt: String
    var answer: String
    var timer: String
}

class Quiz: ObservableObject {
    @Published var title: String
    @Published var questions: [Question]
    
    init(title: String, questions: [Question]) {
        self.title = title
        self.questions = questions
    }
}

struct CreateQuizView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuizView()
    }
}
