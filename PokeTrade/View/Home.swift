//
//  Home.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 19.02.25.
//

import SwiftUI

struct Home: View {

    @EnvironmentObject private var userViewModel: UserViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    if let fireUser = userViewModel.fireUser {
//                        Text("User-ID: \(fireUser.id)")
//                        Text("Email: \(fireUser.email ?? "" )")
                        Text("Hallo \(fireUser.name)")
                    }
                }
                Section("Current value") {

                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        userViewModel.signOut()
                    }, label: {
                        Text("Abmelden")
                    })
                }
            }
            Spacer()
        }
    }
}
#Preview {
    Home()
        .environmentObject(UserViewModel())
}
