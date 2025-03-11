//
//  BackgroundImageModifier.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 10.03.25.
//

import SwiftUI

struct BackgroundImageModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .background(
                Image(colorScheme == .light ? "pika" : "gengar")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5)
                    .ignoresSafeArea()
            )
    }
}
extension View {
    func withBackground() -> some View {
        self.modifier(BackgroundImageModifier())
    }
}
