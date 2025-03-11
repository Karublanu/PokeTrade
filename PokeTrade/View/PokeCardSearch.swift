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

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Suche nach einer Karte", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        Task {
                            await viewModel.fetchCardss()
                        }
                    }

                if viewModel.isLoading {
                    ZStack {
                        Image("Enton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            // .opacity(1)

                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                    }
                    .padding()
                } else {
                    List(viewModel.cards) { card in
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
                                }
                                .frame(width: 120, height: 120)

                                VStack(alignment: .leading) {
                                    Text(card.name ?? "")
                                        .font(.headline)
                                    Text("HP: \(card.hp ?? "")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .bold()
                                }
                                Spacer()

                                Text("\(card.formattedPrice)")
                            }
                        }
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 0.3)
                        )
                        .listRowBackground(Color.black.opacity(0.0))
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
}
