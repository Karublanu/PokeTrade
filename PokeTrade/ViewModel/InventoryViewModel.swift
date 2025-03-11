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

}
