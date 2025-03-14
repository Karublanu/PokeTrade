//
//  Deck.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 13.03.25.
//

import Foundation
import FirebaseFirestore

struct Deck: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let userId: String
    let name: String
    var cards: [DeckCard]
}
