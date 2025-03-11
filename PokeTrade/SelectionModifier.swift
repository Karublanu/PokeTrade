////
////  ButtonModifier.swift
////  PokeTrade
////
////  Created by Mehmet Burak Ünal on 11.03.25.
////
//
// import SwiftUI
//
// struct SelectionModifier: ViewModifier {
//
//    @ObservedObject var viewModel: FavoriteViewModel
//
//    func body(content: Content) -> some View {
//        content
//
//            .overlay(
//                VStack {
//                    if viewModel.isSelected {
//
//                        Button(action: {
//                            viewModel.toggleSelected()
//                            viewModel.favoriteCards.removeAll()
//                        }) {
//                            Text("Done")
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                        .padding()
//                    } else {
//                        Button(action: {
//                            viewModel.toggleSelected()
//                        }) {
//                            Text("Select")
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                        .padding()
//                    }
//
//                },
//                alignment: .topTrailing
//            )
//    }
// }
// extension View {
//    func selectionModifier(viewModel: FavoriteViewModel) -> some View {
//        self.modifier(SelectionModifier(viewModel: viewModel))
//    }
//
// }
