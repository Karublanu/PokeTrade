//
//  NaviView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 27.02.25.
//
import SwiftUI

struct NaviView: View {

    @EnvironmentObject private var userViewModel: UserViewModel
    @StateObject var pokeCardViewModel = PokeCardViewModel()
    @StateObject var favoriteViewModel = FavoriteViewModel()

    var body: some View {

        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            PokeCardSearch()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Favorite()
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
        }
        .environmentObject(userViewModel)
        .environmentObject(pokeCardViewModel)
        .environmentObject(favoriteViewModel)
    }
}
#Preview {
    NaviView()
        .environmentObject(UserViewModel())
}
