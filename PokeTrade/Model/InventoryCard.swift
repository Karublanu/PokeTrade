//
//  Inventory.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 06.03.25.
//

import Foundation
import FirebaseFirestore

struct InventoryCard: Identifiable, Codable, Hashable {
    @DocumentID var id: String?

    let userId: FireUser.ID
    let cardId: PokeCard.ID
    let name: String
    let image: String
    let price: Double

}
