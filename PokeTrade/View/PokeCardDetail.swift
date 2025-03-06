//
//  PokeCardDetailView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 27.02.25.
//

import SwiftUI

struct PokeCardDetailView: View {

    @EnvironmentObject var viewModel: FavoriteViewModel
    let card: PokeCard

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: card.images?.large ?? "")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 400, height: 450)

            HStack {
                Text(card.name ?? "")
                    .font(.largeTitle)
                    .padding()

                Button {
                    viewModel.addFavorite(
                        name: card.name ?? "",
                        hp: card.hp ?? "",
                        types: card.types,
                        image: card.images?.large ?? "",
                        price: card.formattedPrice,
                        cardId: card.id
                    )
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                        .font(.system(size: 32))
                }

            }
            .padding(.horizontal)

            Text("HP: \(card.hp ?? "Unbekannt")")
                .font(.title2)
                .foregroundColor(.gray)

            Text("Price: \(card.formattedPrice)")

            Text("Typen: \(card.types.joined(separator: ", "))")

            Spacer()
        }
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
        images: CardImages(small: nil, large: "https://images.pokemontcg.io/base1/58.png"),
        cardmarket: nil)
    ).environmentObject(FavoriteViewModel())
}
