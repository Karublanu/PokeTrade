//
//  PokeCardRepository.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 25.02.25.
//

import SwiftUI
import Foundation

class PokeCardRepository {

    private let apiKey = ProcessInfo.processInfo.environment["key"]

    func getPokeCards() async throws -> [PokeCard] {
        let urlString = "https://api.pokemontcg.io/v2/cards"

        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        guard let apiKey = ProcessInfo.processInfo.environment["key"] else {
            throw HTTPError.invalidApiKey
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(PokeCardData.self, from: data)

        return decodedData.data.filter {
            $0.cardmarket != nil
        }
    }

    func searchPokeCards(searchQuery: String?) async throws -> [PokeCard] {
        var urlString = "https://api.pokemontcg.io/v2/cards"

        if let query = searchQuery, !query.isEmpty {
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
            urlString += "?q=name:\(encodedQuery)"
        }

        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(PokeCardData.self, from: data)

        return decodedResponse.data.filter {
            $0.cardmarket != nil
        }
    }
}

enum HTTPError: Error {
    case invalidURL, fetchFailed, invalidApiKey

    var message: String {
        switch self {
        case .invalidURL: "Die URL ist ungültig"
        case .fetchFailed: "Laden ist fehlgeschlagen"
        case .invalidApiKey: "Der ApiKey ist Ungültig"
        }
    }
}
