//
//  PokeSearch.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import SwiftUI

struct PokeCardSearchView: View {
    @EnvironmentObject var viewModel: PokeCardViewModel

    var body: some View {
        NavigationView {
            VStack {
                TextField("Suche nach einer Karte", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        Task {
                            await viewModel.fetchCardss()
                        }
                    }

                List(viewModel.cards) { card in

                        HStack {
                            AsyncImage(url: URL(string: card.images.small)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)

                            VStack(alignment: .leading) {
                                Text(card.name)
                                    .font(.headline)
                                Text("HP: \(card.hp ?? "")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                        }
                    }
                }
            }
            .navigationTitle("Pokemon Karten")
            .task {
                await viewModel.fetchCards()
            }
        }
    }
}
#Preview {
    PokeCardSearchView()
        .environmentObject(PokeCardViewModel())
}
