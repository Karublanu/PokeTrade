//
//  Home.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 19.02.25.
//

import SwiftUI

struct Home: View {

    @EnvironmentObject private var userViewModel: UserViewModel
    @EnvironmentObject private var inventoryViewModel: InventoryViewModel
    @EnvironmentObject private var deckViewModel: DeckViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        if let fireUser = userViewModel.fireUser {
                            Text("Hallo \(fireUser.name)")
                                .bold()
                            Text("Email: \(fireUser.email ?? "" )")
                                .bold()
                        }
                    }
                    .listRowBackground(Color.clear)

                    Section("Current value") {
                        Text("\(String(format: "%.2f", inventoryViewModel.totalValue)) €")
                            .font(.title)
                            .bold()
                        Text("Karten: \(inventoryViewModel.cardCount)")
                            .bold()
                    }
                    .listRowBackground(Color.clear)

                    Section {
                        NavigationLink(destination: DeckView()) {
                            Text("Decks")
                                .font(.headline)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                                .shadow(color: .blue, radius: 5, x: 0, y: 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }
                    }
                        .padding()
                            .listRowBackground(Color.clear)

                    }
                    .scrollContentBackground(.hidden)
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
                .withBackground()
                Spacer()
            }
        }
    }

#Preview {
    Home()
        .environmentObject(UserViewModel())
        .environmentObject(InventoryViewModel())
        .environmentObject(DeckViewModel())
}
