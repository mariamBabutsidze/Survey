//
//  QuestionsBusinessModel.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import Foundation

protocol QuestionsBusinessModelWelcome {
    var isLoading: Bool { get }
    var showQuestions: Bool { get }
    func startButtonTapped() async
    func questionsOpened()
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
    var showQuestions = false
    
    init(questionsFetcher: QuestionsFetcher = FetchQuestionsService()) {
        self.questionsFetcher = questionsFetcher
    }
    
    @MainActor
    func startButtonTapped() async {
        isLoading = true
        do {
            questions = try await questionsFetcher.fetchQuestions()
            showQuestions = true
        } catch(let error) {
            self.error = error
        }
    }
    
    func questionsOpened() {
        showQuestions = false
    }
}
