//
//  QuestionsBusinessModel.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import Foundation
import SwiftUINavigation
import Combine

protocol QuestionsBusinessModelImpl: ObservableObject {
    var questions: [Question] { get }
    var answers: [Answer] { get }
    var selectedIndex: Int { get set }
    var submittedAnswers: Int { get set }
    func nextTapped()
    func previousTapped()
    var subject: PassthroughSubject<(Int, Int, String), Never> { get }
    var isLoading: Bool { get }
    var destination: QuestionsBusinessModel.Destination? { get set }
}

final class QuestionsBusinessModel: QuestionsBusinessModelImpl, ObservableObject {
    @Published var destination: QuestionsBusinessModel.Destination?
    @Published var selectedIndex: Int = 0
    @Published var submittedAnswers: Int = 0
    private(set) var answers: [Answer] = []
    @Published var isLoading: Bool = false
    private let answersSubmitter: AnswerSubmiter
    private(set) var questions: [Question] = []
    let subject = PassthroughSubject<(Int, Int, String), Never>()
    private var subscriber: AnyCancellable?
    
    @CasePathable
    enum Destination {
        case alert(AlertState<AlertAction>)
    }
    
    enum AlertAction {
      case confirm
    }
    
    init(destination: Destination? = nil, questions: [Question], answersSubmitter: AnswerSubmiter = FetchQuestionsService()) {
        self.answersSubmitter = answersSubmitter
        self.questions = questions
        self.destination = destination
        answers = questions.map { Answer(id: $0.id, text: "") }
        subscriber = subject.sink(receiveValue: { [weak self] id, index, answer in
            self?.submitAnswer(id: id, index: index, answer: answer)
        })
    }
    
    func nextTapped() {
        selectedIndex += 1
    }
    
    func previousTapped() {
        selectedIndex -= 1
    }
    
    private func submitAnswer(id: Int, index: Int, answer: String) {
        Task { @MainActor in
            isLoading = true
            do {
                try await answersSubmitter.submitAnswer(Answer(id: id, text: answer))
                answers[index].text = answer
                submittedAnswers += 1
                isLoading = false
            }
            catch {
                destination = .alert(.ok)
                isLoading = false
            }
        }
    }
}

extension AlertState where Action == QuestionsBusinessModel.AlertAction {
  static let ok = AlertState(
    title: TextState("Could not submit the answer")
  )
}
