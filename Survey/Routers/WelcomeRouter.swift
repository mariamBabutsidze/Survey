//
//  WelcomeRouter.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import SwiftUI

struct WelcomeRouter {
    
    let routers: Routers.WelcomeRouters
    
    @ViewBuilder
    func configure() -> some View {
        switch routers {
        case .initial:
            WelcomeView(model: QuestionsBusinessModel())
        case .questions:
            QuestionsView()
        }
    }
}
