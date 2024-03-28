//
//  WelcomeBusinessModel.swift
//  Survey
//
//  Created by Mariam Babutsidze on 28.03.24.
//

import Foundation
import SwiftUINavigation

protocol WelcomeBusinessModelIImpl: ObservableObject {
    var isLoading: Bool { get }
    func startButtonTapped() async
    var destination: WelcomeBusinessModel.Destination? { get set }
}

final class WelcomeBusinessModel: WelcomeBusinessModelIImpl, ObservableObject {
    private let questionsFetcher: QuestionsFetcher
    @Published var destination: Destination?
    @Published var questions: [Question] = [] {
        didSet {
            isLoading = false
        }
    }
    @Published var error: Error? = nil {
        didSet {
            isLoading = false
        }
    }
    @Published var isLoading = false
    
    @CasePathable
    enum Destination {
        case questions([Question])
    }
    
    init(questionsFetcher: QuestionsFetcher = FetchQuestionsService(), destination: Destination? = nil) {
        self.questionsFetcher = questionsFetcher
        self.destination = destination
    }
    
    @MainActor
    func startButtonTapped() async {
        isLoading = true
        do {
            questions = try await questionsFetcher.fetchQuestions()
            destination = .questions(questions)
        } catch(let error) {
            self.error = error
        }
    }
}
