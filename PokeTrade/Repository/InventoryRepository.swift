//
//  InventoryRepository.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 06.03.25.
//
import FirebaseFirestore

class InventoryRepository {

    private let collection = Firestore.firestore().collection("Inventory")

    func insertInventoryCard(name: String, cardId: String, image: String, price: Double) async {
        guard let userId = FirebaseManager.shared.userId else { return }

        let inventorCard = InventoryCard(userId: userId, cardId: cardId, name: name, image: image, price: price)

        do {
            try collection.addDocument(from: inventorCard)
        } catch {
            print(error.localizedDescription)
        }
    }

    func findAllInventoryCards() async -> [InventoryCard] {
        guard let userId = FirebaseManager.shared.userId else { return [] }

        do {
            let snapshot = try await collection
                .whereField("userId", isEqualTo: userId)
                .getDocuments()

            let inventoryCard = try snapshot.documents.compactMap { document in
                try document.data(as: InventoryCard.self)
            }
            return inventoryCard
        } catch {
            print("Fehler beim Abrufen der Inventar Karten: \(error.localizedDescription)")
            return []
        }
    }

    func deleteInventorCard(id: String) async {
        do {
            try await collection.document(id).delete()
        } catch {
            print("Fehler beim Entfernen aus der Inventory: \(error.localizedDescription)")
        }
    }
}
