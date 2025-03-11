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
    @StateObject var inventoryViewModel = InventoryViewModel()

    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                    Text("home")
                }
            PokeCardSearch()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Inventory()
                .tabItem {
                    Label("Inventory", systemImage: "menucard")
                }
            Favorite()
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .environmentObject(userViewModel)
        .environmentObject(pokeCardViewModel)
        .environmentObject(favoriteViewModel)
        .environmentObject(inventoryViewModel)

//        .onAppear {
//            // TabBar-Erscheinungsbild anpassen
//            let appearance = UITabBarAppearance()
//            if  UITraitCollection.current.userInterfaceStyle == .dark {
//                appearance.configureWithOpaqueBackground()
//                appearance.backgroundColor = UIColor.black // Hintergrundfarbe im Dark-Mode
//                appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white // Icon-Farbe (nicht ausgewählt)
//                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white] // Textfarbe (nicht ausgewählt)
//                appearance.stackedLayoutAppearance.selected.iconColor = UIColor.yellow // Icon-Farbe (ausgewählt)
//                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.yellow]
//            } else {
//                appearance.configureWithOpaqueBackground() // Opaque-Hintergrund
//                appearance.backgroundColor = UIColor.secondaryLabel // Hintergrundfarbe der TabBar
//                appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white // Icon-Farbe (nicht ausgewählt)
//                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white] // Textfarbe (nicht ausgewählt)
//                appearance.stackedLayoutAppearance.selected.iconColor = UIColor.yellow
//                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.yellow]
//            }
//            UITabBar.appearance().standardAppearance = appearance
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }

    }
}
#Preview {
    NaviView()
        .environmentObject(UserViewModel())
}
