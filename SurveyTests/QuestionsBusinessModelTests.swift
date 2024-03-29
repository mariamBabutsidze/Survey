//
//  QuestionsBusinessModelTests.swift
//  SurveyTests
//
//  Created by Mariam Babutsidze on 29.03.24.
//

import XCTest
@testable import Survey

actor FetchQuestionsServiceSubmitStub: AnswerSubmiter {
    var expectation: XCTestExpectation?
    
    init(expectation: XCTestExpectation?) {
        self.expectation = expectation
    }
    
    func submitAnswer(_ answer: Answer) async throws {
        expectation?.fulfill()
    }
}

actor FetchQuestionsServiceSubmitErrorStub: AnswerSubmiter {
    var expectation: XCTestExpectation?
    
    init(expectation: XCTestExpectation?) {
        self.expectation = expectation
    }
    
    func submitAnswer(_ answer: Answer) async throws {
        expectation?.fulfill()
        throw NetworkError.invalidResponse
    }
}

final class QuestionsBusinessModelTests: 
    XCTestCase {
    
    func test_nextTapped() {
        let model: any QuestionsBusinessModelImpl = QuestionsBusinessModel( questions: Question.mocks)
        model.nextTapped()
        
        XCTAssertEqual(model.selectedIndex, 1)
    }
    
    func test_previousTapped() {
        let model: any QuestionsBusinessModelImpl = QuestionsBusinessModel( questions: Question.mocks)
        model.selectedIndex = 3
        model.previousTapped()
        
        XCTAssertEqual(model.selectedIndex, 2)
    }
    
    func test_submit() {
        let expectation = XCTestExpectation(description: "Submit called")
        let answersSubmitter = FetchQuestionsServiceSubmitStub(expectation: expectation)
        let model: any QuestionsBusinessModelImpl = QuestionsBusinessModel( questions: Question.mocks, answersSubmitter: answersSubmitter)
        let predicate = NSPredicate() { any, _ in
            return model.submittedAnswers == 1
        }
        let expectationAnswer = XCTNSPredicateExpectation(predicate: predicate, object: model)
        
        let subject = model.subject
        subject.send((2, 1, "18"))
        var answers = Array(repeating: "", count: Question.mocks.count)
        answers[1] = "18"
        
        let result = XCTWaiter.wait(for: [expectation])
        XCTAssertEqual(result, .completed)
        
        let resultAnswer = XCTWaiter.wait(for: [expectationAnswer])
        XCTAssertEqual(resultAnswer, .completed)
        XCTAssertEqual(model.submittedAnswers, 1)
        XCTAssertEqual(model.answers, answers)
        XCTAssertEqual(model.isLoading, false)
    }
    
    func test_submitError() {
        let expectation = XCTestExpectation(description: "Submit called")
        let answersSubmitter = FetchQuestionsServiceSubmitErrorStub(expectation: expectation)
        let model: any QuestionsBusinessModelImpl = QuestionsBusinessModel( questions: Question.mocks, answersSubmitter: answersSubmitter)
        let predicate = NSPredicate() { any, _ in
            return model.isLoading == false
        }
        let expectationAnswer = XCTNSPredicateExpectation(predicate: predicate, object: model)
    
        let subject = model.subject
        subject.send((2, 1, "18"))
        
        let result = XCTWaiter.wait(for: [expectation])
        XCTAssertEqual(result, .completed)
        
        let resultAnswer = XCTWaiter.wait(for: [expectationAnswer])
        XCTAssertEqual(resultAnswer, .completed)
        XCTAssertEqual(model.destination, .alert(.ok))
    }
}
