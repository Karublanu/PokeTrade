//
//  Signup.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 19.02.25.
//

import SwiftUI

struct Signup: View {

    @EnvironmentObject private var userViewModel: UserViewModel

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""

    @State private var isPasswordVisible: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // 🔥 Hintergrundbild für den ganzen Screen
                Image("pikapika") // Stelle sicher, dass das Bild im Asset-Katalog existiert!
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    Text("Erstelle ein Konto")
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

                    TextField("Name", text: $name)
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    Button("Sign Up") {
                        Task {
                            await userViewModel.signUp(
                                email: email,
                                password: password,
                                registeredOn: .now,
                                name: name
                            )
                        }
                    }
                    .frame(maxWidth: 270)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)

                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: 270)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Signup")
        }
    }
}

#Preview {
    Signup()
        .environmentObject(UserViewModel())
}
