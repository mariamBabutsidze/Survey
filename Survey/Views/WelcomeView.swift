//
//  WelcomeView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 26.03.24.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject private var navigationState: NavigationState
    var model: QuestionsBusinessModelWelcome
    
    var body: some View {
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
            .onChange(of: model.showQuestions) {
                if model.showQuestions {
                    navigationState.routers.append(.welcome(.questions))
                    model.questionsOpened()
                }
            }
        }
    }
}

#Preview {
    WelcomeView(model: QuestionsBusinessModel())
}
