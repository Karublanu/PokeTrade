//
//  FireStoreRepository.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 05.03.25.
//

import FirebaseFirestore

class FavoriteRepository {

    private let collection = Firestore.firestore().collection("favorite")

    func insertFavorite(name: String, cardId: String, hp: String, types: [String], image: String, price: String) async {
        guard let userId = FirebaseManager.shared.userId else { return }

        let favoriteCard = FavoriteCard(userId: userId, cardId: cardId, name: name, hp: hp, types: types, image: image, price: price)

        do {
            try collection.addDocument(from: favoriteCard)
        } catch {
            print(error.localizedDescription)
        }
    }

    func findAllFavoriteCards() async -> [FavoriteCard] {
        guard let userId = FirebaseManager.shared.userId else { return [] }

        do {
            let querySnapshot = try await collection
                .whereField("userId", isEqualTo: userId)
                .getDocuments()

            let favoriteCards = querySnapshot.documents.compactMap { document in
                try? document.data(as: FavoriteCard.self)
            }
            return favoriteCards
        } catch {
            print("Fehler beim Abrufen der favorisierten Karten: \(error.localizedDescription)")
            return []
        }
    }
    func deleteFavoriteCard(by id: String) async {
        do {
            try await collection.document(id).delete()
        } catch {
            print("Fehler beim Entfernen aus der Favoritenliste: \(error.localizedDescription)")
        }
    }
}
