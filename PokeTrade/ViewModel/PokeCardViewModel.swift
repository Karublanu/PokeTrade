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

    // Zustandsvariablen für Filter
    @Published var sortByPrice: SortOrder = .none
    @Published var selectedType: String?

    private let repository = PokeCardRepository()

    // Enum für Sortierreihenfolge
    enum SortOrder {
        case ascending, descending, none
    }

    // Gefilterte und sortierte Karten
    var filteredCards: [PokeCard] {
        var filtered = cards

        // Filter nach Typ
        if let selectedType = selectedType {
            filtered = filtered.filter { $0.types.contains(selectedType) }
        }

        // Sortierung nach Preis
        switch sortByPrice {
        case .ascending:
            return filtered.sorted {
                ($0.cardmarket?.prices?.averageSellPrice ?? 0) < ($1.cardmarket?.prices?.averageSellPrice ?? 0)
            }
        case .descending:
            return filtered.sorted {
                ($0.cardmarket?.prices?.averageSellPrice ?? 0) > ($1.cardmarket?.prices?.averageSellPrice ?? 0)
            }
        case .none:
            return filtered
        }
    }

    // Lade Karten
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

    // Suche nach Karten
    func fetchCardss() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedCards = try await repository.searchPokeCards(searchQuery: searchText)
            if fetchedCards.isEmpty {
                errorMessage = "Kein Pokémon mit diesem Namen gefunden."
            }
            self.cards = fetchedCards
        } catch {
            errorMessage = "Fehler beim Laden der Karten: \(error.localizedDescription)"
        }

        isLoading = false
    }

    // Setze den Filter nach Typ
    func filterByType(_ type: String?) {
        selectedType = type
    }

    // Setze die Sortierreihenfolge nach Preis
    func sortByPrice(_ order: SortOrder) {
        sortByPrice = order
    }
        func getSortedCards(descending: Bool) -> [PokeCard] {
            let sortedCards = cards.sorted {
                let price1 = $0.cardmarket?.prices?.averageSellPrice ?? 0
                let price2 = $1.cardmarket?.prices?.averageSellPrice ?? 0
                return descending ? price1 > price2 : price1 < price2
            }
            return sortedCards
        }

        let imageLinks: [(imageName: String, url: String)] = [
            (imageName: "booster1", url: "https://www.tcg-trade.de/p/paldeas-schicksale-booster-deutsch"),
            (imageName: "booster2", url: "https://www.tcg-trade.de/p/pokemon-trick-or-trade-booster-englisch"),
            (imageName: "booster3", url: "https://www.tcg-trade.de/p/karmesin-und-purpur-obsidianflammen-booster-deutsch"),
            (imageName: "booster4", url: "https://www.tcg-trade.de/p/pokemon-go-booster-deutsch")
        ]

        func openURL(urlString: String) {
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
}

// import SwiftUI
//
// @MainActor
// class PokeCardViewModel: ObservableObject {
//    @Published var cards: [PokeCard] = []
//    @Published var searchText: String = ""
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
//    
//    
//    private let repository = PokeCardRepository()
//
//    func getSortedCards(descending: Bool) -> [PokeCard] {
//        let sortedCards = cards.sorted {
//            let price1 = $0.cardmarket?.prices?.averageSellPrice ?? 0
//            let price2 = $1.cardmarket?.prices?.averageSellPrice ?? 0
//            return descending ? price1 > price2 : price1 < price2
//        }
//        return sortedCards
//    }
//
//    func fetchCardss() async {
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            let fetchedCards = try await PokeCardRepository().searchPokeCards(searchQuery: searchText)
//            if fetchedCards.isEmpty {
//                errorMessage = "Kein Pokémon mit diesem Namen gefunden."
//            }
//            self.cards = fetchedCards
//        } catch {
//            errorMessage = "Fehler beim Laden der Karten: \(error.localizedDescription)"
//        }
//
//        isLoading = false
//    }
//    func fetchCards() async {
//        isLoading = true
//        errorMessage = nil
//
//        do {
//            let fetchedCards = try await repository.getPokeCards()
//            self.cards = fetchedCards
//        } catch {
//            self.errorMessage = "Fehler beim Laden der Karten: \(error.localizedDescription)"
//        }
//
//        isLoading = false
//    }
//
//    let imageLinks: [(imageName: String, url: String)] = [
//        (imageName: "booster1", url: "https://www.tcg-trade.de/p/paldeas-schicksale-booster-deutsch"),
//        (imageName: "booster2", url: "https://www.tcg-trade.de/p/pokemon-trick-or-trade-booster-englisch"),
//        (imageName: "booster3", url: "https://www.tcg-trade.de/p/karmesin-und-purpur-obsidianflammen-booster-deutsch"),
//        (imageName: "booster4", url: "https://www.tcg-trade.de/p/pokemon-go-booster-deutsch")
//    ]
//
//    func openURL(urlString: String) {
//        if let url = URL(string: urlString) {
//            UIApplication.shared.open(url)
//        }
//    }
//
// }
