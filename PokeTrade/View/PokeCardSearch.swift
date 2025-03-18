//
//  PokeSearch.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import SwiftUI

struct PokeCardSearch: View {
    @EnvironmentObject var viewModel: PokeCardViewModel
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @EnvironmentObject var inventoryViewModel: InventoryViewModel
    @EnvironmentObject var deckViewModel: DeckViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // Suchfeld
                TextField("Suche nach einer Karte", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        Task {
                            await viewModel.fetchCardss()
                        }
                    }

                // Filter- und Sortieroptionen
                HStack {
                    // Filter nach Typ
                    Menu {
                        Button(action: {
                            viewModel.filterByType(nil) // Kein Filter
                        }) {
                            Text("Alle Typen")
                        }
                        ForEach(Array(Set(viewModel.cards.flatMap { $0.types })), id: \.self) { type in
                            Button(action: {
                                viewModel.filterByType(type)
                            }) {
                                Text(type.capitalized)
                            }
                        }
                    } label: {
                        Label("Typ: \(viewModel.selectedType?.capitalized ?? "Alle")", systemImage: "line.3.horizontal.decrease.circle")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }

                    // Sortierung nach Preis
                    Menu {
                        Button(action: {
                            viewModel.sortByPrice(.none) // Keine Sortierung
                        }) {
                            Text("Keine Sortierung")
                        }
                        Button(action: {
                            viewModel.sortByPrice(.ascending) // Aufsteigend
                        }) {
                            Text("Preis: Aufsteigend")
                        }
                        Button(action: {
                            viewModel.sortByPrice(.descending) // Absteigend
                        }) {
                            Text("Preis: Absteigend")
                        }
                    } label: {
                        Label("Sortieren", systemImage: "arrow.up.arrow.down")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                // Ladeanzeige
                if viewModel.isLoading {
                    ZStack {
                        Image("Enton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .opacity(8)

                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                            .foregroundColor(.white)
                    }
                    .padding()
                } else {
                    // Liste der gefilterten und sortierten Karten
                    List(viewModel.filteredCards) { card in
                        NavigationLink(
                            destination: PokeCardDetailView(card: card)
                                .environmentObject(favoriteViewModel)
                                .environmentObject(inventoryViewModel)
                        ) {
                            HStack {
                                AsyncImage(url: URL(string: card.images?.small ?? "")) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                        .scaleEffect(1.5, anchor: .center)
                                        .foregroundColor(.white)
                                }
                                .frame(width: 120, height: 120)

                                VStack(alignment: .leading) {
                                    Text(card.name ?? "")
                                        .font(.headline)
                                    Text("HP: \(card.hp ?? "")")
                                        .font(.subheadline)
                                        .bold()
                                }
                                Spacer()

                                Text("\(card.formattedPrice)")
                                    .bold()
                            }
                        }
                        .padding(10)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(8)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                    }
                    .navigationTitle("Pokemon Karten")
                }
            }
            .task {
                if viewModel.cards.isEmpty {
                    await viewModel.fetchCards()
                }
            }
            .scrollContentBackground(.hidden)
            .withBackground()
        }
    }
}

#Preview {
    PokeCardSearch()
        .environmentObject(PokeCardViewModel())
        .environmentObject(FavoriteViewModel())
        .environmentObject(InventoryViewModel())
        .environmentObject(DeckViewModel())
}
// import SwiftUI
//
// struct PokeCardSearch: View {
//
//    @EnvironmentObject var viewModel: PokeCardViewModel
//    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
//    @EnvironmentObject var inventoryViewModel: InventoryViewModel
//    @EnvironmentObject var deckViewModel: DeckViewModel
//    @EnvironmentObject var viewModelPokeCard: PokeCardViewModel
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                TextField("Suche nach einer Karte", text: $viewModel.searchText)
//                    .padding()
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .onSubmit {
//                        Task {
//                            await viewModel.fetchCardss()
//                        }
//                    }
//
//                if viewModel.isLoading {
//                    ZStack {
//                        Image("Enton")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 300, height: 300)
//                            .opacity(8)
//
//                        ProgressView()
//                            .scaleEffect(1.5, anchor: .center)
//                            .foregroundColor(.white)
//                    }
//                    .padding()
//                } else {
//                    List(viewModel.cards) { card in
//                        NavigationLink(
//                            destination: PokeCardDetailView(card: card)
//                                .environmentObject(favoriteViewModel)
//                                .environmentObject(inventoryViewModel)
//                        ) {
//                            HStack {
//                                AsyncImage(url: URL(string: card.images?.small ?? "")) { image in
//                                    image.resizable().scaledToFit()
//                                } placeholder: {
//
//                                    ProgressView()
//                                        .scaleEffect(1.5, anchor: .center)
//                                        .foregroundColor(.white)
//
//                                }
//                                .frame(width: 120, height: 120)
//
//                                VStack(alignment: .leading) {
//                                    Text(card.name ?? "")
//                                        .font(.headline)
//                                    Text("HP: \(card.hp ?? "")")
//                                        .font(.subheadline)
//                                        .bold()
//                                }
//                                Spacer()
//
//                                Text("\(card.formattedPrice)")
//                                    .bold()
//
//                            }
//                        }
//                        .padding(10)
//                        .background(Color.gray.opacity(0.4))
//                        .cornerRadius(8)
//                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.black, lineWidth: 0.5)
//
//                        )
//                    }
//
//                    .navigationTitle("Pokemon Karten")
//                }
//            }
//            .task {
//                if viewModel.cards.isEmpty {
//                    await viewModel.fetchCards()
//                }
//            }
//            .scrollContentBackground(.hidden)
//            .withBackground()
//        }
//    }
// }
//
// #Preview {
//    PokeCardSearch()
//        .environmentObject(PokeCardViewModel())
//        .environmentObject(FavoriteViewModel())
//        .environmentObject(InventoryViewModel())
//        .environmentObject(DeckViewModel())
// }
