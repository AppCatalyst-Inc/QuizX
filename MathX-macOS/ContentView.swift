//
//  ContentView.swift
//  MathX-macOS
//
//  Created by Tristan on 27/02/2023.
//

import SwiftUI

struct Quiz {
    let title: String
    let questions: [Question]
}

struct Question {
    let prompt: String
    let answer: String
}

class QuizStore: ObservableObject {
    @Published var quizzes: [Quiz] = []
}

struct TeacherView: View {
    @ObservedObject var quizStore: QuizStore
    @State private var quizTitle = ""
    @State private var prompt = ""
    @State private var answer = ""
    @State private var questions: [Question] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a Quiz")
                .font(.largeTitle)
            TextField("Quiz Title", text: $quizTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Divider()
            List {
                ForEach(questions, id: \.prompt) { question in
                    HStack {
                        Text(question.prompt)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text(question.answer)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                HStack {
                    TextField("Prompt", text: $prompt)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addQuestion) {
                        Text("Add Question")
                    }
                }
                .padding()
            }
            Divider()
            Button(action: saveQuiz) {
                Text("Save Quiz")
            }
            .background(Color.red)
            .frame(width: 150, height: 50)

        }
        .padding()
    }
    
    func addQuestion() {
        questions.append(Question(prompt: prompt, answer: answer))
        prompt = ""
        answer = ""
    }
    
    func saveQuiz() {
        let quiz = Quiz(title: quizTitle, questions: questions)
        quizStore.quizzes.append(quiz)
        quizTitle = ""
        questions = []
    }
}

struct StudentView: View {
    let quiz: Quiz
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var score = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text(quiz.title)
                .font(.largeTitle)
            Divider()
            Text(quiz.questions[currentQuestion].prompt)
                .font(.title)
                .padding()
            TextField("Answer", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: checkAnswer) {
                Text("Submit")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            Spacer()
            Text("Score: \(score)")
                .font(.title)
                .padding()
        }
        .frame(minWidth: 300, minHeight: 300)
    }
    
    func checkAnswer() {
        let question = quiz.questions[currentQuestion]
        if answer == question.answer {
            score += 1
        }
        answer = ""
        currentQuestion += 1
        if currentQuestion >= quiz.questions.count {
            // TODO: -- loops around, make a finished screen
            currentQuestion = 0
            score = 0
        }
    }
}

struct ContentView: View {
    @ObservedObject var quizStore = QuizStore()
    @State private var isTeacherView = true
    @State private var selectedQuiz: Quiz?
    
    var body: some View {
        NavigationStack {
            VStack {
                if isTeacherView {
                    TeacherView(quizStore: quizStore)
                } else {
                    QuizListView(quizzes: quizStore.quizzes) { quiz in
                        selectedQuiz = quiz
                    }
                }
                Spacer()
                HStack {
                    Button(action: {
                        isTeacherView = true
                        selectedQuiz = nil
                    }) {
                        Text("Teacher View")
                    }
                    .background(isTeacherView ? Color.blue : Color.blue)
                    .frame(width: 150, height: 50)
                    
                    Spacer()
                    Button(action: {
                        isTeacherView = false
                        selectedQuiz = nil
                    }) {
                        Text("Student View")
                    }
                    .background(isTeacherView ? Color.blue : Color.blue)
                    .frame(width: 150, height: 50)
                }
                .padding()
            }
            .navigationTitle(selectedQuiz == nil ? "Math Quiz" : selectedQuiz!.title)
        }
    }
}

struct QuizListView: View {
    let quizzes: [Quiz]
    let didSelectQuiz: (Quiz) -> Void
    
    var body: some View {
        List(quizzes, id: \.title) { quiz in
            NavigationLink(destination: StudentView(quiz: quiz)) {
                HStack {
                    Text(quiz.title)
                        .font(.headline)
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
