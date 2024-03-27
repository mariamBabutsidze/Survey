//
//  SurveyApp.swift
//  Survey
//
//  Created by Mariam Babutsidze on 26.03.24.
//

import SwiftUI

@main
struct SurveyApp: App {
    @StateObject private var navigationState = NavigationState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.routers) {
                ContentView()
                    .navigationDestination(for: Routers.self) { router in
                        switch router {
                        case .welcome(let routers):
                            WelcomeRouter(routers: routers).configure()
                        }
                    }
            }
            .environmentObject(navigationState)
        }
    }
}
