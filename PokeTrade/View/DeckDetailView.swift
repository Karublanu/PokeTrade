//
//  DeckDetailView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 13.03.25.
//

import SwiftUI

struct DeckDetailView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())
    ]
    let deck: Deck

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(deck.cards, id: \.cardId) { card in
                    VStack {
                        AsyncImage(url: URL(string: card.image)) { image in
                            image.resizable().scaledToFit()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1.5)
                                )
                        } placeholder: {
                            Image("pokeback")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                                .cornerRadius(10)
                            ProgressView()
                        }
                        .frame(width: 250, height: 250)
                    }
                }
            }
            .padding(8)
//            .contextMenu {
//                Button(action: onDelete) {
//                    Label("Delete", systemImage: "trash")
//                }
//            }
        }

        .withBackground()
        .navigationTitle(deck.name)

    }
}
