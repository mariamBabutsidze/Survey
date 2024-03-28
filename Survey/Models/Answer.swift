//
//  Answer.swift
//  Survey
//
//  Created by Mariam Babutsidze on 28.03.24.
//

import Foundation

struct Answer: Equatable {
    let id: Int
    var text: String
}

extension Answer {
    static let mock = Self(id: 1, text: "")
}
