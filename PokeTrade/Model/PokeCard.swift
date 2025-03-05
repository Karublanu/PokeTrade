//
//  PokeCard.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import Foundation

struct PokeCardData: Decodable {
    let data: [PokeCard]
}

struct PokeCard: Identifiable, Decodable {
    let id: String
    let name: String?
    let hp: String?
    let types: [String]
    let images: CardImages?
    let cardmarket: Cardmarket?

}

struct CardImages: Decodable {
    let small: String?
    let large: String?
}

struct Cardmarket: Decodable {
    let url: String?
    let updatedAt: String?
    let prices: Prices?
}

struct Prices: Decodable {
    let averageSellPrice: Double
}
extension PokeCard {
    var formattedPrice: String {
        if let averageSellPrice = cardmarket?.prices?.averageSellPrice {
            return String(format: "%.2f", averageSellPrice) + " €"
        }
        return "Unbekannt"
    }
}
