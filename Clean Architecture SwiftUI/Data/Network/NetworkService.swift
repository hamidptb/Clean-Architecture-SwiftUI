//
//  NetworkService.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Foundation
import Combine

protocol NetworkServiceInterface {
    func fetch<T: Decodable>(from url: URL) -> AnyPublisher<T, PostError>
}

final class NetworkService: NetworkServiceInterface {
    func fetch<T: Decodable>(from url: URL) -> AnyPublisher<T, PostError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in PostError.networkError }
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return PostError.decodingError
                }
                return PostError.unknown(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
