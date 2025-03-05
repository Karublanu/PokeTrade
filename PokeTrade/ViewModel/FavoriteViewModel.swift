//
//  FavoriteViewModel.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 05.03.25.
//
import SwiftUI

@MainActor
class FavoriteViewModel: ObservableObject {

    @Published var favorites: [FavoritePokeCard] = []
    private var favoriteRepo = FavoriteRepository()

    func addFavorite(name: String, hp: String, types: [String], image: String, price: String) {
        Task {
            await favoriteRepo.insertFavorite(name: name, hp: hp, types: types, image: image, price: price)
        }
    }

    func loadFavorites() async {
        Task {
            let fetchedFavorites = await favoriteRepo.findAllFavoriteCards()
            DispatchQueue.main.async {
                self.favorites = fetchedFavorites
            }
        }
    }

    func deledeFavorite(id: String) {
        Task {
            await favoriteRepo.deleteFavoriteCard(by: id)
            await loadFavorites()
        }
    }
}
