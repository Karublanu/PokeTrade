//
//  Deck.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 12.03.25.
//

import Foundation
import FirebaseFirestore

struct DeckCard: Identifiable, Codable, Hashable {
    @DocumentID var id: String?

    let userId: FireUser.ID
    let cardId: String
    let name: String
    let image: String
    let price: Double

}
