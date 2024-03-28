//
//  QuestionView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 28.03.24.
//

import SwiftUI

struct QuestionView: View {
    var question: Question
    @State var answer: String = ""
    
    var body: some View {
        VStack {
            Text(question.question)
                .bold()
            TextField("Type here for an answer...", text: $answer)
                .textFieldStyle(.roundedBorder)
                .padding()
                .bold()
            Button {
                
            }
            label: {
                Text("Submit")
            }
            .buttonStyle(SubmitButtonStyle())
            Spacer()
        }
    }
}

#Preview {
    QuestionView(question: Question.mock)
}
