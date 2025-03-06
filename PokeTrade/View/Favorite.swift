//
//  Favorite.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 05.03.25.
//

import SwiftUI

struct Favorite: View {
    @EnvironmentObject var viewModel: FavoriteViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.favorites) { favorite in
                    HStack {
                        AsyncImage(url: URL(string: favorite.image)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 120)

                        VStack(alignment: .leading) {
                            Text(favorite.name)
                                .font(.headline)
                            Text("HP: \(favorite.hp)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Price: \(favorite.price)")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let favorite = viewModel.favorites[index]
                        viewModel.deledeFavorite(id: favorite.id ?? "")
                    }
                }
            }

            .navigationBarTitle("Favorites")
            .task {
                await viewModel.loadFavorites()
            }
        }
    }
}

#Preview {
    Favorite()
        .environmentObject(FavoriteViewModel())
}
