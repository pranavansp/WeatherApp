//
//  FirstAppearMofier.swift
//  WeatherApp
//
//  Created by Pranavan Sivarajah on 2024-06-08.
//

import SwiftUI

public struct FirstAppearMofier: ViewModifier {

    private let action: () async -> Void
    @State private var hasAppeared = false
    
    public init(_ action: @escaping () async -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .task {
                guard !hasAppeared else { return }
                hasAppeared = true
                await action()
            }
    }
}

public extension View {
    func onFirstAppear(_ action: @escaping () async -> Void) -> some View {
        modifier(FirstAppearMofier(action))
    }
}
