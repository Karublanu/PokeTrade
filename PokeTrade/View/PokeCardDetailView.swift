//
//  PokeCardDetailView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 27.02.25.
//

import SwiftUI

struct PokeCardDetailView: View {

    let card: PokeCard

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: card.images.large)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)

            Text(card.name)
                .font(.largeTitle)
                .padding()

            Text("HP: \(card.hp ?? "Unbekannt")")
                .font(.title2)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle(card.name)
    }
}
