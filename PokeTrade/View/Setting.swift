//
//  Setting.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 10.03.25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userViewModel: UserViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("notifications") var notifications: Bool = false
    @AppStorage("language") private var language: String = "Deutsch"

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profiel")) {
                    Text("Profiel bearbeiten")

                    Button(action: {
                        userViewModel.signOut()
                    }, label: {
                        Text("Abmelden")
                    })
                }
                .listRowBackground(Color.gray.opacity(0.4))

                Section(header: Text("Darstellung")) {
                    Toggle("Dark Mode aktivieren", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { _, newValue in
                            setDarkMode(newValue)
                        }
                }
                .listRowBackground(Color.gray.opacity(0.4))

                Section(header: Text("App")) {
                    Section(header: Text("Notifications").bold()) {
                        Toggle(("Notifications"), isOn: $notifications)
                        Picker("Language", selection: $language) {
                            Text("English").tag("English")
                            Text("Deutsch").tag("Deutsch")
                            Text("Español").tag("Español")
                        }
                    }
                }
                .listRowBackground(Color.gray.opacity(0.4))

            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Einstellungen")
            .withBackground()
        }
    }

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
