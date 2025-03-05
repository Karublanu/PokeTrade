//
//  PokeSearch.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import SwiftUI

struct PokeCardSearch: View {

    @EnvironmentObject var viewModel: PokeCardViewModel

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

                List(viewModel.cards) { card in
                    NavigationLink(destination: PokeCardDetailView(card: card)) {
                        HStack {
                            AsyncImage(url: URL(string: card.images?.small ?? "")) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 120)

                            VStack(alignment: .leading) {
                                Text(card.name ?? "")
                                    .font(.headline)
                                Text("HP: \(card.hp ?? "")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()

                            Text("\(card.formattedPrice)")
                        }
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1)

                    )
                }
                .navigationTitle("Pokemon Karten")
                .task {
                    await viewModel.fetchCards()

                }
            }
        }
    }
}
#Preview {
    PokeCardSearch()
        .environmentObject(PokeCardViewModel())
}
