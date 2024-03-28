//
//  QuestionsBusinessModel.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import Foundation
import SwiftUINavigation

protocol QuestionsBusinessModelImpl: ObservableObject {
    var questions: [Question] { get }
}

final class QuestionsBusinessModel: QuestionsBusinessModelImpl, ObservableObject {
    var questions: [Question] = []
    
    init(questions: [Question]) {
        self.questions = questions
    }
}
