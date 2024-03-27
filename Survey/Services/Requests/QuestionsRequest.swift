//
//  QuestionsRequest.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

enum QuestionsRequest: RequestProtocol {
    case questionList
    case submit(Int, String)
    
    var host: String {
        "xm-assignment.web.app"
    }
    
    var body: [String : Any] {
        switch self {
        case .questionList:
            [:]
        case .submit(let id, let answer):
            ["id": id, "answer": answer]
        }
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var path: String {
        switch self {
        case .questionList:
            "/questions"
        case .submit:
            "/question/submit"
        }
    }

    var requestType: RequestType {
        switch self {
        case .questionList:
                .GET
        case .submit:
                .POST
        }
    }
}

