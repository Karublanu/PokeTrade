//
//  Inventory.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 07.03.25.
//

import SwiftUI

struct Inventory: View {

    let columns = [GridItem(.flexible()), GridItem(.flexible())
    ]

//    @EnvironmentObject var pokeCardViewModel: PokeCardViewModel
//    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @EnvironmentObject var inventoryViewModel: InventoryViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(inventoryViewModel.inventoryCard) { inventory in
                        VStack {
                            AsyncImage(url: URL(string: inventory.image)!) { image in
                                image.resizable().scaledToFit()
                            }placeholder: {
                                Image("pokeback")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(10)
                                ProgressView()
                            }
                            .frame(width: 200, height: 200)

                            VStack {
                                Text(inventory.name)
                                    .font(.headline)
                                    .bold()
                                Spacer()
                                Text(String(format: "%.2f", inventory.price) + " €")
                                    .font(.subheadline)
                                    .bold()

                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Inventory")
            .task {
                await inventoryViewModel.loadInventory()
            }
            .withBackground()

        }
    }
}
#Preview {
    Inventory()
        .environmentObject(InventoryViewModel())
}
