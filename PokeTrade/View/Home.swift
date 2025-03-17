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
    @EnvironmentObject private var pokeCardViewModel: PokeCardViewModel

    @State private var sortDescending: Bool = true

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

                    Section("Top Karten") {
                        HStack {
                            Text("Sortieren nach Preis:")
                                .bold()

                            Spacer()

                            Button(action: {
                                sortDescending.toggle()
                            }, label: {
                                Image(systemName: sortDescending ? "arrow.up" : "arrow.down")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            })
                        }
                        .padding(.bottom, 5)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(pokeCardViewModel.getSortedCards(descending: sortDescending).prefix(5)) { card in
                                    VStack {
                                        AsyncImage(url: URL(string: card.images?.large ?? "")) { image in
                                            image.resizable().scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 120, height: 120)

                                        Text(card.name ?? "Unbekannt")
                                            .font(.headline)
                                        Text("\(card.cardmarket?.prices?.averageSellPrice ?? 0, specifier: "%.2f") €")
                                            .font(.subheadline)
                                            .bold()
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)

                    Section("Booster") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(pokeCardViewModel.imageLinks, id: \.imageName) { link in
                                    Button(action: {
                                        // Öffne die URL beim Klicken auf das Bild
                                        pokeCardViewModel.openURL(urlString: link.url)
                                    }) {
                                        Image(link.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Home")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        userViewModel.signOut()
//                    }, label: {
//                        Text("Abmelden")
//                    })
//                }
//            }
            .withBackground()
            .task {
                await pokeCardViewModel.fetchCards()
            }
            Spacer()
        }
    }
}

#Preview {
    Home()
        .environmentObject(UserViewModel())
        .environmentObject(InventoryViewModel())
        .environmentObject(DeckViewModel())
        .environmentObject(PokeCardViewModel())
}
