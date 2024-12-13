//
//  UserRepository.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Foundation
import Combine

final class UserRepository: UserRepositoryInterface {
    private let networkService: NetworkServiceInterface
    private let baseURL = "https://jsonplaceholder.typicode.com/users"
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }
    
    func fetchUser(id: Int) -> AnyPublisher<User, PostError> {
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            return Fail(error: PostError.invalidURL).eraseToAnyPublisher()
        }
        
        return networkService.fetch(from: url)
    }
}
