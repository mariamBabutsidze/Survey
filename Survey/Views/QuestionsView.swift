//
//  QuestionsView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import SwiftUI

struct QuestionsView<Model: QuestionsBusinessModelImpl>: View {
    @ObservedObject var model: Model
    
    var body: some View {
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
            ForEach(Array(model.questions.enumerated()), id: \.offset) { _, question in
                QuestionView(question: question)
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
}

#Preview {
    QuestionsView(model: QuestionsBusinessModel(questions: Question.mocks))
}
