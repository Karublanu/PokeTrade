//
//  Poke.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import SwiftUI

@MainActor
class PokeCardViewModel: ObservableObject {
    @Published var cards: [PokeCard] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository = PokeCardRepository()

    var filteredCards: [PokeCard] {
        if searchText.isEmpty {
            return cards
        } else {
            return cards.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    func fetchCardss() async {
        do {
            self.cards = try await repository.searchPokeCards(searchQuery: searchText)
        } catch {
            print("Fehler beim Laden der Karten: \(error.localizedDescription)")
        }
    }

    func fetchCards() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedCards = try await repository.getPokeCards()
            self.cards = fetchedCards
        } catch {
            self.errorMessage = "Fehler beim Laden der Karten: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
