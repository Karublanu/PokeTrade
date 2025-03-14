//
//  Deck.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 12.03.25.
//

import SwiftUI

struct DeckView: View {
    @EnvironmentObject var viewModel: DeckViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(viewModel.decks) { deck in
                        VStack {
                            AsyncImage(url: URL(string: deck.image)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)

                            Text(deck.name)
                                .font(.headline)
                            Text("\(deck.price, specifier: "%.2f") €")
                                .font(.subheadline)
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.deleteDeck(id: deck.id ?? "")
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Decks")
            .task {
                await viewModel.loadDecks()
            }
        }
        .withBackground()
    }
}

#Preview {
    DeckView()
        .environmentObject(DeckViewModel())
}
