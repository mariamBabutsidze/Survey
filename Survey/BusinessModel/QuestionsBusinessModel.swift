//
//  QuestionsBusinessModel.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import Foundation

protocol QuestionsBusinessModelWelcome {
    var isLoading: Bool { get }
    func startButtonTapped() async
}

@Observable
class QuestionsBusinessModel: QuestionsBusinessModelWelcome {
    let questionsFetcher: QuestionsFetcher
    var questions: [Question] = [] {
        didSet {
            isLoading = false
        }
    }
    var error: Error? = nil {
        didSet {
            isLoading = false
        }
    }
    var isLoading = false
    
    init(questionsFetcher: QuestionsFetcher = FetchQuestionsService()) {
        self.questionsFetcher = questionsFetcher
    }
    
    @MainActor
    func startButtonTapped() async {
        isLoading = true
        do {
            questions = try await questionsFetcher.fetchQuestions()
        } catch(let error) {
            self.error = error
        }
    }
}
