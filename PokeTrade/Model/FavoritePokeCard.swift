//
//  Untitled.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 04.03.25.
//

import Foundation
import FirebaseFirestore

struct FirestorePokeCard: Identifiable, Codable {
    @DocumentID var id: String?
    
    let userId: FireUser.ID
    let name: String
    let hp: String
    let types: [String]
    let image: String
    let price: String
    let isFavorite: Bool
}
