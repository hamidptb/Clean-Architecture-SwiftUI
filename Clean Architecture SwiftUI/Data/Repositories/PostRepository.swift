//
//  PostRepository.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Foundation
import Combine

final class PostRepository: PostRepositoryInterface {
    private let networkService: NetworkServiceInterface
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }
    
    func fetchPosts() -> AnyPublisher<[Post], PostError> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: PostError.invalidURL).eraseToAnyPublisher()
        }
        
        return networkService.fetch(from: url)
    }
}
