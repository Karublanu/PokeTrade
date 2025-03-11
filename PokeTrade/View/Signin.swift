//
//  LoginView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 18.02.25.
//

import SwiftUI

struct Signin: View {

    @EnvironmentObject private var userViewModel: UserViewModel

    @State private var isPasswordVisible: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""

    @State private var errorMessage: String?
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("pikapika")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    Text("Willkommen!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)

                    TextField("Email", text: $email)
                        .frame(width: 300, height: 50)
                         .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .foregroundColor(.black)
                        } else {
                            SecureField("Password", text: $password)
                                .foregroundColor(.black)
                        }
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)

                    Button("Log In") {
                        Task {
                            do {
                                try await userViewModel.signIn(email: email, password: password)
                            } catch {
                                errorMessage = error.localizedDescription
                                showAlert = true
                            }
                        }
                    }
                    .frame(maxWidth: 270)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)

                    NavigationLink(destination: Signup()) {
                        Text("Signup")
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: 270)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Spacer() // Platzhalter für eine bessere Anordnung
                }
                .padding()
            }
            .navigationTitle("Login")
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Email oder Password Fehler"),
                  message: Text(errorMessage ?? "Unbekannter Fehler"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    Signin()
        .environmentObject(UserViewModel())
}
