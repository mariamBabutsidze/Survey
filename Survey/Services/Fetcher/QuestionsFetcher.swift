//
//  QuestionsFetcher.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import Foundation

protocol QuestionsFetcher {
    func fetchQuestions() async throws -> [Question]
}

protocol AnswerSubmiter {
    func submitAnswer(_ answer: Answer) async throws
}

actor FetchQuestionsService: QuestionsFetcher, AnswerSubmiter  {
    func fetchQuestions() async throws -> [Question] {
        let requestData = QuestionsRequest.questionList
        let questions: [Question] = try await NetworkingManager().load(requestData)
        return questions
    }
    
    func submitAnswer(_ answer: Answer) async throws {
        let requestData = QuestionsRequest.submit(answer.id, answer.text)
        _ = try await NetworkingManager().load(requestData)
    }
}
