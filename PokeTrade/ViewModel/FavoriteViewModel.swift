//
//  FavoriteViewModel.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 05.03.25.
//
import SwiftUI

@MainActor
class FavoriteViewModel: ObservableObject {

    @Published var favoriteCards: [FavoriteCard] = []
    @Published var isSelected: Bool = false
    private let repository = FavoriteRepository()

    init() {
        Task {
            await loadFavorites()
        }
    }

    func toggleSelected() {
        isSelected.toggle()
    }

    func loadFavorites() async {
        let favorites = await repository.findAllFavoriteCards()
        DispatchQueue.main.async {
            self.favoriteCards = favorites
        }
    }

    func isFavorite(cardId: String) -> Bool {
        return favoriteCards.contains { $0.cardId == cardId }
    }

    func toggleFavorite(card: PokeCard) async {
        if let favorite = favoriteCards.first(where: { $0.cardId == card.id }) {
            await repository.deleteFavoriteCard(by: favorite.id ?? "")
            DispatchQueue.main.async {
                self.favoriteCards.removeAll { $0.cardId == card.id }
            }
        } else {
            await repository.insertFavorite(
                name: card.name ?? "",
                cardId: card.id,
                hp: card.hp ?? "",
                types: card.types,
                image: card.images?.large ?? "",
                price: card.formattedPrice
            )
            await loadFavorites()
        }
    }

    func deledeFavorite(id: String) {
        Task {
            await repository.deleteFavoriteCard(by: id)
            await loadFavorites()
        }
    }
}
