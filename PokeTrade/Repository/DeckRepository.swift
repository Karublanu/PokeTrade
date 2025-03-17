//
//  DeckRepository.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 12.03.25.
//

import FirebaseFirestore

class DeckRepository {
    private let decksCollection = Firestore.firestore().collection("decks")

    func createDeck(name: String) async -> Deck? {
        guard let userId = FirebaseManager.shared.userId else { return nil }

        let deck = Deck(userId: userId, name: name, cards: [])

        do {
            let documentRef = try decksCollection.addDocument(from: deck)
            let documentId = documentRef.documentID
            var newDeck = deck
            newDeck.id = documentId
            return newDeck
        } catch {
            print("Fehler beim Erstellen des Decks: \(error.localizedDescription)")
            return nil
        }
    }

    func findAllDecks() async -> [Deck] {
        guard let userId = FirebaseManager.shared.userId else { return [] }

        do {
            let snapshot = try await decksCollection
                .whereField("userId", isEqualTo: userId)
                .getDocuments()

            let decks = try snapshot.documents.compactMap { document in
                try document.data(as: Deck.self)
            }
            return decks
        } catch {
            print("Fehler beim Abrufen der Decks: \(error.localizedDescription)")
            return []
        }
    }

    func addCardToDeck(deckId: String, card: DeckCard) async {
        do {
            let deckRef = decksCollection.document(deckId)
            try await deckRef.updateData([
                "cards": FieldValue.arrayUnion([try Firestore.Encoder().encode(card)])
            ])
        } catch {
            print("Fehler beim Hinzufügen der Karte zum Deck: \(error.localizedDescription)")
        }
    }

    func deleteDeck(deckId: String) async {
        do {
            try await decksCollection.document(deckId).delete()
        } catch {
            print("Fehler beim Löschen des Decks: \(error.localizedDescription)")
        }
    }

    func deleteCardFromDeck(deckId: String, card: DeckCard) async {
        do {
            let deckRef = decksCollection.document(deckId)
            try await deckRef.updateData([
                "cards": FieldValue.arrayRemove([try Firestore.Encoder().encode(card)])
            ])
        } catch {
            print("Fehler beim Löschen der Karte aus dem Deck: \(error.localizedDescription)")
        }
    }
}
