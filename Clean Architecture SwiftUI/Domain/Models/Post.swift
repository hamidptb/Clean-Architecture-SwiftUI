//
//  Post.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

struct Post: Identifiable, Codable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum PostError: Error {
    case networkError
    case decodingError
    case invalidURL
    case unknown(Error)
}
