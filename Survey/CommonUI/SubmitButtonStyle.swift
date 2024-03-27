//
//  SubmitButtonStyle.swift
//  Survey
//
//  Created by Mariam Babutsidze on 27.03.24.
//

import SwiftUI

struct SubmitButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.cyan)
            .opacity(configuration.isPressed ? 0.4 : 1)
            .foregroundStyle(.white)
            .clipShape(Rectangle())
            .cornerRadius(10)
            .bold()
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
