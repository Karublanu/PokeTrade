//
//  Deck.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 12.03.25.
//

import SwiftUI

struct DeckView: View {

    let columns = [GridItem(.flexible()), GridItem(.flexible())
    ]

    @EnvironmentObject var viewModel: DeckViewModel
    @State private var showingCreateDeckAlert = false
    @State private var newDeckName = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.decks) { deck in
                        NavigationLink {
                            DeckDetailView(deck: deck)
                        } label: {
                            VStack {
                                Text(deck.name)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteDeck(deckId: deck.id ?? "")
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .padding()
            }

            .navigationTitle("Decks")
            .toolbar {
                Button {
                    showingCreateDeckAlert = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .alert("Create Deck", isPresented: $showingCreateDeckAlert) {
                TextField("Deck Name", text: $newDeckName)
                Button("Create") {
                    Task {
                        await viewModel.createDeck(name: newDeckName)
                        newDeckName = ""
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
            .task {
                await viewModel.loadDecks()
            }
            .withBackground()
        }
    }
}

#Preview {
    DeckView()
        .environmentObject(DeckViewModel())
}
