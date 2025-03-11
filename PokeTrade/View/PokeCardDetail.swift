import SwiftUI

struct PokeCardDetailView: View {

    @EnvironmentObject var viewModelFavorite: FavoriteViewModel
    @EnvironmentObject var viewModelInventory: InventoryViewModel
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
                    Task {
                        await viewModelFavorite.toggleFavorite(card: card)
                    }
                } label: {
                    Image(systemName: viewModelFavorite.isFavorite(cardId: card.id) ? "heart.fill" : "heart")
                        .foregroundColor(viewModelFavorite.isFavorite(cardId: card.id) ? .red : .gray)
                        .font(.system(size: 32))
                }

            }
            .padding(.horizontal)

            Text("HP: \(card.hp ?? "Unbekannt")")
                .font(.title2)
                .foregroundColor(.black)
                .bold()

            Text("Price: \(card.formattedPrice)")
                .foregroundColor(.black)
                .bold()

            Text("Typen: \(card.types.joined(separator: ", "))")
                .foregroundColor(.black)
                .bold()

            Button {
                Task {
                    await viewModelInventory.addInventoryCard(card: card)
                }
            } label: {
                Text("In Inventory hinzufügen")
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
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
