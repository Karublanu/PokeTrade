//
//  PokeTradeApp.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 11.02.25.
//

import SwiftUI
import Firebase

@main
struct PokeTradeApp: App {

    @StateObject private var userViewModel = UserViewModel()

    init() {
        FirebaseApp.configure()

    }
    var body: some Scene {
        WindowGroup {
            if userViewModel.isUserLoggedIn {
                NaviView()
                    .environmentObject(userViewModel)
            } else {
                Signin()
                    .environmentObject(userViewModel)
            }
        }
    }
}
