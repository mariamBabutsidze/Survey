//
//  WelcomeView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 26.03.24.
//

import SwiftUI

struct WelcomeView: View {
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
        }
    }
}

#Preview {
    WelcomeView(model: QuestionsBusinessModel())
}
