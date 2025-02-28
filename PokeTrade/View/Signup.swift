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
            NavigationStack {
                ZStack {
                    Image("Glurak")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 200, maxHeight: 200)
                        .ignoresSafeArea()
                }
                    TextField("Email", text: $email)
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                }

                Section("Personal Information") {
                    TextField("Name", text: $name)
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)

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
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Cancel") {
                        dismiss()
                    }
                    .frame(maxWidth: 270)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    .navigationTitle("Signup")
                }

            }
            .padding()

        }
    }

    #Preview{
        Signup()
            .environmentObject(UserViewModel())
    }
