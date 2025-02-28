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

                Button("Log In") {
                    Task {
                        await userViewModel.signIn(email: email, password: password)
                    }
                }
                .frame(maxWidth: 270)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
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

                .navigationTitle("Login")
            }
            .padding()
        }
    }
}
#Preview {
    Signin()
        .environmentObject(UserViewModel())
}
