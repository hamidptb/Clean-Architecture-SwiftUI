//
//  User.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

struct User: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let email: String
    let username: String
}
