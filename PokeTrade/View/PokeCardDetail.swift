//
//  PokeSearch.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import SwiftUI

struct PokeCardDetailView: View {
    @EnvironmentObject var viewModelFavorite: FavoriteViewModel
    @EnvironmentObject var viewModelInventory: InventoryViewModel
    @EnvironmentObject var viewModelDecks: DeckViewModel
    @State private var selectedDeckId: String?

    let card: PokeCard

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: card.images?.large ?? "")) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 400, height: 450)

                HStack {
                    Text(card.name ?? "")
                        .font(.largeTitle)
                        .padding()

                    Button {
                        Task {
                            await viewModelFavorite.toggleFavorite(card: card)
                        }
                    } label: {
                        Image(systemName: viewModelFavorite.isFavorite(cardId: card.id) ? "heart.fill" : "heart")
                            .foregroundColor(viewModelFavorite.isFavorite(cardId: card.id) ? .red : .gray)
                            .font(.system(size: 32))
                    }
                }
                .padding(.horizontal)

                Text("HP: \(card.hp ?? "Unbekannt")")
                    .font(.title2)
                    .foregroundColor(.black)
                    .bold()

                Text("Price: \(card.formattedPrice)")
                    .foregroundColor(.black)
                    .bold()

                Text("Typen: \(card.types.joined(separator: ", "))")
                    .foregroundColor(.black)
                    .bold()

                // Dropdown-Menü für Decks
                Picker("Deck auswählen", selection: $selectedDeckId) {
                    Text("Kein Deck ausgewählt").tag(String?.none) // Standardoption
                    ForEach(viewModelDecks.decks) { deck in
                        Text(deck.name).tag(deck.id as String?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                Button {
                    Task {
                        if let deckId = selectedDeckId {
                            await viewModelDecks.addCardToDeck(deckId: deckId, card: card)
                        }
                    }
                } label: {
                    Text("In Deck hinzufügen")
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedDeckId == nil) // Deaktivieren, wenn kein Deck ausgewählt ist

                Button {
                    Task {
                        await viewModelInventory.addInventoryCard(card: card)
                    }
                } label: {
                    Text("In Inventory hinzufügen")
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .withBackground()
            .task {
                await viewModelDecks.loadDecks() // Lade die Decks beim Erscheinen der View
            }
        }
    }
}
#Preview {
    PokeCardDetailView(card: PokeCard(
        id: "1",
        name: "Pikachu",
        hp: "60",
        types: ["Electric"],
        images: CardImages(small: nil, large: "https://images.pokemontcg.io/base1/58.png"),
        cardmarket: nil)
    )
    .environmentObject(FavoriteViewModel())
    .environmentObject(InventoryViewModel())
    .environmentObject(DeckViewModel())
}
