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
    let name: String
    let hp: String?
    let types: [String]
    let images: CardImages
    let tcgplayer: TCGPlayerInfo?

}

struct CardImages: Decodable {
    let small: String
    let large: String
}

struct TCGPlayerInfo: Decodable {
    let url: String
    let updatedAt: String
    let prices: Prices
}

struct Prices: Decodable {
    let low: Double
    let mid: Double
    let high: Double
    let market: Double
    let directLow: Double
}
