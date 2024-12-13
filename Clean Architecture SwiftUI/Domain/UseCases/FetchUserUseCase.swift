//
//  FetchUserUseCase.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Combine

protocol FetchUserUseCaseInterface {
    func execute(userId: Int) -> AnyPublisher<User, PostError>
}

final class FetchUserUseCase: FetchUserUseCaseInterface {
    private let repository: UserRepositoryInterface
    
    init(repository: UserRepositoryInterface) {
        self.repository = repository
    }
    
    func execute(userId: Int) -> AnyPublisher<User, PostError> {
        repository.fetchUser(id: userId)
    }
}
