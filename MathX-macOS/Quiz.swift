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
                .foregroundColor(.white)
            TextField("Quiz Title", text: $quizTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            Divider()
                .background(Color.white)
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
                        .background(Color.gray)
                        .cornerRadius(10)
                    TextField("Answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.gray)
                        .cornerRadius(10)
                    Button(action: addQuestion) {
                        Text("Add Question")
                            .foregroundColor(.gray)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            Divider()
                .background(Color.white)
            Button(action: saveQuiz) {
                Text("Save Quiz")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .background(Color(red: 0.17, green: 0.24, blue: 0.31))
        .cornerRadius(20)
        .padding(.horizontal, 20)
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

struct QuizListView: View {
    let quizzes: [Quiz]
    let didSelectQuiz: (Quiz) -> Void
    
    var body: some View {
        if quizzes.count > 0 {
            List(quizzes, id: \.title) { quiz in
                NavigationLink(destination: AnswerView(quiz: quiz)) {
                    HStack {
                        Text(quiz.title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                }
            }
            .scrollContentBackground(.hidden)
        } else {
            HStack {
                Spacer()
                Text("There are no quizzes available.")
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct AnswerView: View {
    let quiz: Quiz
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var score = 0
    
    @State private var showingFinished = false
    @State private var closeQuiz = false
    
    @State private var showingLeaveWarning = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 30) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(quiz.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Question \(currentQuestion + 1) of \(quiz.questions.count)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(quiz.questions[currentQuestion].prompt)
                        .font(.title)
                        .fontWeight(.semibold)
                    TextField("Answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40)
                        .padding(.leading, 5)
                }
                .padding(.horizontal, 20)
                
                Button(action: checkAnswer) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
                
                Spacer()
                
                HStack(alignment: .center) {
                    Text("Score: \(score)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        showingLeaveWarning.toggle()
                    }) {
                        Text("End Quiz")
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .alert("Are you sure you want to end the quiz?", isPresented: $showingLeaveWarning) {
                        Button("No", role: .cancel) { }
                        Button("Yes", role: .destructive) {
                            closeQuiz = true
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .navigationBarBackButtonHidden(true)
            .frame(minWidth: 300, minHeight: 300)
            .sheet(isPresented: $showingFinished) {
                FinishedView(score: $score, currentQuestion: $currentQuestion, closeQuiz: $closeQuiz)
            }
            .onChange(of: closeQuiz) { newValue in
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func checkAnswer() {
        let question = quiz.questions[currentQuestion]
        if answer == question.answer {
            score += 1
        }
        answer = ""
        currentQuestion += 1
        if currentQuestion >= quiz.questions.count {
            currentQuestion -= 1
            showingFinished = true
        }
    }
}


struct FinishedView: View {
    
    @Binding var score: Int
    @Binding var currentQuestion: Int
    @Binding var closeQuiz: Bool
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Finished")
                .font(.title)
                .padding(.bottom, 5)
            Text("Score: \(score)")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Button {
                score = 0
                closeQuiz.toggle()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Submit and Close Quiz")
            }
        }
        .padding(100)
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        Text("Quiz View")
    }
}
