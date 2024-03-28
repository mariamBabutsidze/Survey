//
//  QuestionView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 28.03.24.
//

import SwiftUI
import Combine

struct QuestionView: View {
    var question: Question
    @State var answer: String = ""
    var submitted: Bool
    var index: Int
    var subject: PassthroughSubject<(Int, Int, String), Never>
    
    var body: some View {
        VStack {
            Text(question.question)
                .bold()
            TextField("Type here for an answer...", text: $answer)
                .textFieldStyle(.roundedBorder)
                .padding()
                .bold()
            Button {
                subject.send((question.id, index, answer))
            }
            label: {
                Text(submitted ? "Already Submitted" : " Submit")
            }
            .buttonStyle(SubmitButtonStyle())
            .disabled(submitted || answer.isEmpty)
            Spacer()
        }
    }
}

#Preview {
    QuestionView(question: Question.mock, answer: "", submitted: false, index: 0, subject: PassthroughSubject<(Int, Int, String), Never>())
}
