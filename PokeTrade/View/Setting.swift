//
//  Setting.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 10.03.25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Darstellung")) {
                    Toggle("Dark Mode aktivieren", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { _, newValue in
                            setDarkMode(newValue)
                        }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Einstellungen")
            .withBackground()
        }
    }

    // Funktion zum Setzen des Dark-Modes
    private func setDarkMode(_ isDarkMode: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
        }
    }
}

#Preview {
    SettingsView()
}
