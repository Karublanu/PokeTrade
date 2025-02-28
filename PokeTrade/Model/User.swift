//
//  User.swift
//  PokeTrade
//
//  Created by Mehmet Burak Ünal on 19.02.25.
//

import Foundation

struct FireUser: Codable, Identifiable {
    var id: String
    var email: String?
    var registeredOn: Date
    var name: String
}
