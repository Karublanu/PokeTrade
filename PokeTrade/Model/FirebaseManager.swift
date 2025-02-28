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

    let auth: Auth
    let database: Firestore

    var userId: String? {
        return auth.currentUser?.uid
    }

    private init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        self.auth = Auth.auth()
        self.database = Firestore.firestore()
    }
}
