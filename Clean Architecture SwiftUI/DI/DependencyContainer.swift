//
//  DependencyContainer.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    
    // Network
    private lazy var networkService: NetworkServiceInterface = {
        NetworkService()
    }()
    
    // Repositories
    private lazy var postRepository: PostRepositoryInterface = {
        PostRepository(networkService: networkService)
    }()
    
    private lazy var userRepository: UserRepositoryInterface = {
        UserRepository(networkService: networkService)
    }()
    
    // Use Cases
    private lazy var fetchPostsUseCase: FetchPostsUseCaseInterface = {
        FetchPostsUseCase(repository: postRepository)
    }()
    
    private lazy var fetchUserUseCase: FetchUserUseCaseInterface = {
        FetchUserUseCase(repository: userRepository)
    }()
    
    // View Models
    func makePostsViewModel() -> PostsViewModel {
        PostsViewModel(fetchPostsUseCase: fetchPostsUseCase)
    }
    
    func makePostDetailViewModel(post: Post) -> PostDetailViewModel {
        PostDetailViewModel(post: post, fetchUserUseCase: fetchUserUseCase)
    }
}
