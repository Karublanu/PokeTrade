//
//  Inventory.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 06.03.25.
//

import Foundation
import FirebaseFirestore

struct InventoryCard: Identifiable, Codable {
    @DocumentID var id: String?

    let userId: FireUser.ID
    let cardId: String
    let name: String
    let image: String
    let price: Double

}
