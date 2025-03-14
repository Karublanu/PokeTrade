//
//  InventoryViewModel.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 07.03.25.
//

import SwiftUI

@MainActor
class InventoryViewModel: ObservableObject {

    @Published var inventoryCard: [InventoryCard] = []
    private let repository = InventoryRepository()

    init() {
        Task {
            await loadInventory()
        }
    }

    var totalValue: Double {
        inventoryCard.reduce(0) { $0 + ($1.price) }
    }

    var cardCount: Int {
        inventoryCard.count
    }

    func loadInventory() async {
        let inventory = await repository.findAllInventoryCards()
        self.inventoryCard = inventory
    }

    func addInventoryCard(card: PokeCard) async {
        await repository.insertInventoryCard(
            name: card.name ?? "",
            cardId: card.id,
            image: card.images?.large ?? "",
            price: card.cardmarket?.prices?.averageSellPrice ?? 0.0)

    }

    func deleteInventory(id: String) {
        Task {
            await repository.deleteInventorCard(id: id)
            await loadInventory()
        }
    }

    private func getBackgroundColor(for card: PokeCard) -> Color {
        guard let firstType = card.types.first else { return Color.gray.opacity(0.2) }

        switch firstType {
        case "Fire":
            return Color.red.opacity(0.3)
        case "Water":
            return Color.blue.opacity(0.3)
        case "Grass":
            return Color.green.opacity(0.3)
        case "Electric":
            return Color.yellow.opacity(0.3)
        case "Psychic":
            return Color.purple.opacity(0.3)
        case "Fighting":
            return Color.orange.opacity(0.3)
        case "Dark":
            return Color.black.opacity(0.3)
        default:
            return Color.gray.opacity(0.2)
        }
    }
}
