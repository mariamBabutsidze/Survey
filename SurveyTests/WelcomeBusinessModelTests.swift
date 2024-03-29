//
//  WelcomeBusinessModelTests.swift
//  SurveyTests
//
//  Created by Mariam Babutsidze on 29.03.24.
//

import XCTest
@testable import Survey

actor FetchQuestionsStub: QuestionsFetcher {
    func fetchQuestions() async throws -> [Survey.Question] {
        Question.mocks
    }
}

actor FetchQuestionsErrorStub: QuestionsFetcher {
    func fetchQuestions() async throws -> [Survey.Question] {
        throw NetworkError.invalidResponse
    }
}

final class WelcomeBusinessModelTests: XCTestCase {

    func test_startButtonTapped() async {
        let model: any WelcomeBusinessModelIImpl = WelcomeBusinessModel(questionsFetcher: FetchQuestionsStub())
        await model.startButtonTapped()
        
        XCTAssertEqual(model.destination, WelcomeBusinessModel.Destination.questions(Question.mocks))
        XCTAssertEqual(model.isLoading, false)
    }
    
    func test_startButtonTappedError() async {
        let model: any WelcomeBusinessModelIImpl = WelcomeBusinessModel(questionsFetcher: FetchQuestionsErrorStub())
        await model.startButtonTapped()
        
        XCTAssertEqual(model.destination, WelcomeBusinessModel.Destination.alert(.ok))
        XCTAssertEqual(model.isLoading, false)
    }
}
