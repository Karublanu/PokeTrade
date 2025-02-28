//
//  NaviView.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 27.02.25.
//
import SwiftUI

struct NaviView: View {

    var body: some View {

        @StateObject var userViewModel = UserViewModel()
        @StateObject var pokeCardViewModel = PokeCardViewModel()

        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            PokeCardSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .environmentObject(UserViewModel())
        .environmentObject(PokeCardViewModel())
    }
}
#Preview {
    NaviView()
}
