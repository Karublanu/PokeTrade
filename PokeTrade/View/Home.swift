//
//  Home.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 19.02.25.
//

import SwiftUI

struct Home: View {

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @EnvironmentObject private var userViewModel: UserViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        if let fireUser = userViewModel.fireUser {
                            Text("Hallo \(fireUser.name)")
                            Text("Email: \(fireUser.email ?? "" )")
                        }
                    }

                    Section("Current value") {
                        Text("0,00")
                            .font(.title)
                        Text("Karten 0")
                    }

                    LazyVGrid(columns: columns, spacing: 20) {
                        VStack {
                            Text("Decks")
                                .font(.headline)
                                .frame(maxWidth: .infinity, maxHeight: 20)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                                .shadow(color: .blue, radius: 5, x: 0, y: 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }

                        VStack {
                            Text("Inventory")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(10)
                                .shadow(color: .green, radius: 5, x: 0, y: 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 2)
                                )
                        }
                    }
                    .padding()
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
