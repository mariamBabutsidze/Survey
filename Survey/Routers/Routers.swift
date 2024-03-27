//
//  Routers.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import Foundation

enum Routers: Hashable {
    case welcome(WelcomeRouters)
    
    enum WelcomeRouters: Hashable {
        case initial
        case questions
    }
}
