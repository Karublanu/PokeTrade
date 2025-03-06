//
//  PokeCard.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import Foundation

struct PokeCardData: Codable {
    let data: [PokeCard]
}

struct PokeCard: Identifiable, Codable {
    let id: String
    let name: String?
    let hp: String?
    let types: [String]
    let images: CardImages?
    let cardmarket: Cardmarket?

}

struct CardImages: Codable {
    let small: String?
    let large: String?
}

struct Cardmarket: Codable {
    let url: String?
    let updatedAt: String?
    let prices: Prices?
}

struct Prices: Codable {
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
