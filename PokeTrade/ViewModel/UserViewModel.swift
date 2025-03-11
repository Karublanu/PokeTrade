//
//  UserViewModel.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 19.02.25.
//

import Firebase
import FirebaseAuth

@MainActor
class UserViewModel: ObservableObject {

    private var auth = Auth.auth()

    @Published private var user: FirebaseAuth.User?

    @Published var fireUser: FireUser?

    @Published var errorMessage: String?

    var isUserLoggedIn: Bool {
        user != nil
    }

    init() {
        checkAuth()
    }

    private func checkAuth() {
        user = auth.currentUser
        if let uid = user?.uid {
            fetchUser(userID: uid)
        }
    }

    func signIn(email: String, password: String) async throws {
            let result = try await auth.signIn(withEmail: email, password: password)
            user = result.user
            errorMessage = nil
            fetchUser(userID: result.user.uid)
    }

    func signUp(email: String, password: String, registeredOn: Date, name: String) async {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            user = result.user
            errorMessage = nil
            guard let email = result.user.email else { fatalError("Found a user without an email.") }
            createUser(userID: result.user.uid, email: email, registeredOn: registeredOn, name: name)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func signOut() {
        do {
            try auth.signOut()
            user = nil
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func createUser(userID: String, email: String, registeredOn: Date, name: String) {
        let user = FireUser(
            id: userID,
            email: email,
            registeredOn: Date(),
            name: name

        )
        do {
            try FirebaseManager.shared.database.collection("users").document(userID).setData(from: user)
            fetchUser(userID: userID)
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchUser(userID: String) {
        Task {
            do {
                let snapshot = try await FirebaseManager.shared.database
                    .collection("users")
                    .document(userID)
                    .getDocument()
                self.fireUser = try snapshot.data(as: FireUser.self)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
