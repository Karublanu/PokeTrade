//
//  PokeCardDetailView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 27.02.25.
//

import SwiftUI

struct PokeCardDetailView: View {

    let card: PokeCard
    @EnvironmentObject var viewModel: FavoriteViewModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: card.images?.large ?? "")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)

            Text(card.name ?? "")
                .font(.largeTitle)
                .padding()

            Text("HP: \(card.hp ?? "Unbekannt")")
                .font(.title2)
                .foregroundColor(.gray)

            Text("Price: \(card.formattedPrice)")

            Spacer()
        }
        Button("Add Favorite") {
            viewModel.addFavorite(
                name: card.name ?? "",
                hp: card.hp ?? "",
                types: card.types,
                image: card.images?.large ?? "",
                price: card.formattedPrice
            )
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .navigationTitle(card.name ?? "")
    }
}
#Preview {
    PokeCardDetailView(card: PokeCard(
        id: "1",
        name: "Pikachu",
        hp: "60",
        types: ["Electric"],
        images: CardImages(small: nil,
                           large: "https://images.pokemontcg.io/base1/58.png"),
        cardmarket: nil)
    ).environmentObject(FavoriteViewModel())
}
