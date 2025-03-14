import Foundation
import FirebaseFirestore

struct Deck: Identifiable, Codable, Hashable {
    @DocumentID var id: String? // Automatisch von Firestore zugewiesene ID
    let userId: String // ID des Benutzers
    let name: String // Name des Decks
    var cards: [DeckCard] // Karten im Deck
}

struct DeckCard: Identifiable, Codable, Hashable {
    @DocumentID var id: String? // Automatisch von Firestore zugewiesene ID
    let cardId: String // ID der Karte
    let name: String // Name der Karte
    let image: String // Bild-URL der Karte
    let price: Double // Preis der Karte
}