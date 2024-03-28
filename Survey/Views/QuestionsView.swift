//
//  QuestionsView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import SwiftUI
import SwiftUINavigation

struct QuestionsView<Model: QuestionsBusinessModelImpl>: View {
    @ObservedObject var model: Model
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Answers submitted: \(model.submittedAnswers)")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(.gray.opacity(0.2))
                        .padding(.top, 20)
                }
                .padding(.bottom)
                TabView(selection: $model.selectedIndex) {
                    ForEach(Array(model.questions.enumerated()), id: \.offset) { index, question in
                        let answer = model.answers[index]
                        QuestionView(question: question, answer: answer.text, submitted: !answer.text.isEmpty, index: index, subject: model.subject)
                    }
                }
                .navigationTitle("\(model.selectedIndex + 1)/\(model.questions.count)")
                .tabViewStyle(.page)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            model.previousTapped()
                        }) {
                            Text("Previous")
                        }
                        .disabled(model.selectedIndex == 0)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            model.nextTapped()
                        }) {
                            Text("Next")
                        }
                        .disabled(model.selectedIndex == model.questions.count - 1)
                    }
                }
            }
            .disabled(model.isLoading)
            if model.isLoading {
                ProgressView()
            }
        }
        .alert(
          unwrapping: $model.destination,
          case: /QuestionsBusinessModel.Destination.alert
        ) {_ in 
            
        }
    }
}

#Preview {
    QuestionsView(model: QuestionsBusinessModel(questions: Question.mocks))
}
