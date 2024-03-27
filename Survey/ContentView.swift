//
//  ContentView.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WelcomeRouter(routers: .initial).configure()
    }
}

#Preview {
    ContentView()
}
