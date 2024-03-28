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
        Button {
            
        }
        label: {
           
                Text("Start Survey")
        }
    }
}

#Preview {
    QuestionsView(model: QuestionsBusinessModel(questions: Question.mock))
}
