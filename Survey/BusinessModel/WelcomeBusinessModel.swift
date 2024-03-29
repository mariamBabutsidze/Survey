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
    @Published var destination: Destination?
    @Published var isLoading = false
    
    private let questionsFetcher: QuestionsFetcher
    private var error: Error? = nil {
        didSet {
            isLoading = false
        }
    }
    private var questions: [Question] = [] {
        didSet {
            isLoading = false
        }
    }
    
    @CasePathable
    enum Destination: Equatable {
        case questions([Question])
        case  alert(AlertState<AlertAction>)
    }
    
    enum AlertAction {
        case confirm
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
            destination = .alert(.ok)
        }
    }
}

extension AlertState where Action == WelcomeBusinessModel.AlertAction {
    static let ok = AlertState(
        title: TextState("Error loading questions")
    )
}
