//
//  FetchPostsUseCase.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Combine

protocol FetchPostsUseCaseInterface {
    func execute() -> AnyPublisher<[Post], PostError>
}

final class FetchPostsUseCase: FetchPostsUseCaseInterface {
    private let repository: PostRepositoryInterface
    
    init(repository: PostRepositoryInterface) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Post], PostError> {
        repository.fetchPosts()
    }
}
