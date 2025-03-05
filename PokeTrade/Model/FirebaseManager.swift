//
//  FirebaseManager.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 19.02.25.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {

    static let shared = FirebaseManager()

    let auth: Auth = Auth.auth()
    let database: Firestore = Firestore.firestore()

    var userId: String? {
        return auth.currentUser?.uid
    }
}
