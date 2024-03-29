//
//  WelcomeView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 26.03.24.
//

import SwiftUI
import SwiftUINavigation

struct WelcomeView<Model: WelcomeBusinessModelIImpl>: View {
    @ObservedObject var model: Model
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    Task {
                        await model.startButtonTapped()
                    }
                }
            label: {
                if model.isLoading {
                    ProgressView()
                } else {
                    Text("Start Survey")
                }
            }
            .buttonStyle(SubmitButtonStyle())
            .disabled(model.isLoading)
            }
            .navigationDestination(
                unwrapping: $model.destination, case: /WelcomeBusinessModel.Destination.questions
            ) { $questions in
                QuestionsView(model: QuestionsBusinessModel(questions: questions))
            }
            .alert(
              unwrapping: $model.destination,
              case: /WelcomeBusinessModel.Destination.alert
            ) {_ in
                
            }
        }
    }
}

#Preview {
    WelcomeView(model: WelcomeBusinessModel())
}
