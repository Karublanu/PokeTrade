//
//  FireStoreRepository.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 05.03.25.
//

import FirebaseFirestore


class FireStoreRepository {
    
    private let collection = Firestore.firestore().collection("favorite")
    
    func insertFavorite(name: String, hp: String, types: [String], image: String, price: String) {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        let favoriteCard = FirestorePokeCard(userId: userId, name: name , hp: hp, types: types, image: image, price: price, isFavorite: true )
        
        do {
            try collection.addDocument(from: favoriteCard)
        }catch{
            print(error.localizedDescription)
        }
    }

}
