//
//  Favorite.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 05.03.25.

import SwiftUI

struct Favorite: View {

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]

    @EnvironmentObject var viewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.favoriteCards) { favoriteCard in
                            VStack {
                                AsyncImage(url: URL(string: favoriteCard.image)) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    Image("pokeback")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(10)
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)

                                VStack(alignment: .leading) {
                                    Text(favoriteCard.name)
                                        .font(.headline)
                                    Text("HP: \(favoriteCard.hp)")
                                        .font(.subheadline)
                                        .bold()
                                    Text("Price: \(favoriteCard.price)")
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                            .contextMenu {
                                Button {
                                    viewModel.deledeFavorite(id: favoriteCard.id ?? "")
                                } label: {
                                    Text("Delete")
                                }
                            }

                            .padding(.vertical, 8)
                        }

                    }
                }

                .navigationBarTitle("Favorites")
                .task {
                    await viewModel.loadFavorites()

                }
            }
            .withBackground()
        }
    }
}

#Preview {
    Favorite()
        .environmentObject(FavoriteViewModel())
}
