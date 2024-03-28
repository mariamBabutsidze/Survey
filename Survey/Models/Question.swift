//
//  Question.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import Foundation

struct Question: Decodable {
    let id: Int
    let question: String
}

extension Question {
    static let mock = [Self(id: 10, question: "What is your name?"),
                       Self(id: 1, question: "What is your favourite food?"),
                       Self(id: 2, question: "How old are you?"),
                       Self(id: 3, question: "Do you love dogs?")]
}
