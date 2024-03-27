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
    func submitAnswer(id: Int, answer: String) async throws
}

actor FetchQuestionsService: QuestionsFetcher, AnswerSubmiter  {
    func fetchQuestions() async throws -> [Question] {
        let requestData = QuestionsRequest.questionList
        let questions: [Question] = try await NetworkingManager().load(requestData)
        return questions
    }
    
    func submitAnswer(id: Int, answer: String) async throws {
        let requestData = QuestionsRequest.submit(id, answer)
        _ = try await NetworkingManager().load(requestData)
    }
}
