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

    @EnvironmentObject var viewModel: InventoryViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.inventoryCard) { inventory in
                        CardView(inventory: inventory) {
                            if let id = inventory.id {
                                viewModel.deleteInventory(id: id)
                            }
                        }
                    }
//                    .background(Color.black.opacity(0.5))
//                    .cornerRadius(8)
//                    .listRowBackground(Color.clear)
//                    .listRowSeparator(.hidden)
                }

            }
            .padding(.horizontal)
            .navigationTitle("Inventory")
            .task {
                await viewModel.loadInventory()
            }
            .withBackground()

        }

    }
}
#Preview {
    Inventory()
        .environmentObject(InventoryViewModel())
}
