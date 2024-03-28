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
    var selectedIndex: Int { get set }
    var submittedAnswers: Int { get set }
}

final class QuestionsBusinessModel: QuestionsBusinessModelImpl, ObservableObject {
    @Published var selectedIndex: Int = 0
    @Published var submittedAnswers: Int = 0
    private(set) var questions: [Question] = []
    
    init(questions: [Question]) {
        self.questions = questions
    }
}
