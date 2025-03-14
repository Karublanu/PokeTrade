//
//  CardView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 12.03.25.
//

import SwiftUI

struct CardView: View {
    let inventory: InventoryCard
    let onDelete: () -> Void

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: inventory.image)) { image in
                image.resizable().scaledToFit()
//                    .padding(.top, 15)
            } placeholder: {
                Image("pokeback")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 15)
                    .frame(width: 170, height: 170)
                    .cornerRadius(20)

                ProgressView()
            }
            .frame(width: 170, height: 170)

            VStack {
                Text(inventory.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Text(String(format: "%.2f", inventory.price) + " €")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .padding(.top, 15)
        .background(Color.black.opacity(0.5)) // Hintergrund für die Karte
        .cornerRadius(10) // Abgerundete Ecken
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1) // Rand um die Karte
        )
        .contextMenu {
            Button(action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    Inventory()
        .environmentObject(InventoryViewModel())
}
