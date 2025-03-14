//
//  DeckViewModel.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 12.03.25.
//

import SwiftUI

@MainActor
class DeckViewModel: ObservableObject {
    @Published var decks: [Deck] = []
    private var repository = DeckRepository()

    init() {
        Task {
            await loadDecks()
        }
    }

    func loadDecks() async {
        let decks = await repository.findAllDecks()
        print("geladene dacks: \(decks)")
        self.decks = decks
    }

    func createDeck(name: String) async {
        if let newDeck = await repository.createDeck(name: name) {
            decks.append(newDeck)
        }
    }

    func addCardToDeck(deckId: String, card: PokeCard) async {
        let deckCard = DeckCard(
            cardId: card.id,
            name: card.name ?? "",
            image: card.images?.large ?? "",
            price: card.cardmarket?.prices?.averageSellPrice ?? 0.0
        )
        print("Hinzugefügte Karte: \(deckCard)")
        await repository.addCardToDeck(deckId: deckId, card: deckCard)
        await loadDecks()
    }

    func deleteDeck(deckId: String) async {
        await repository.deleteDeck(deckId: deckId)
        await loadDecks()
    }
}
