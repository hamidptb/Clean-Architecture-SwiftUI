//
//  PostDetailViewModel.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Foundation
import Combine

final class PostDetailViewModel: ObservableObject {
    @Published private(set) var state = ViewState.loaded(postDetails: nil)
    private let post: Post
    private let fetchUserUseCase: FetchUserUseCaseInterface
    private var cancellables = Set<AnyCancellable>()
    
    struct PostDetails {
        let post: Post
        let user: User
    }
    
    enum ViewState {
        case loaded(postDetails: PostDetails?)
        case loading
        case error(String)
    }
    
    init(post: Post, fetchUserUseCase: FetchUserUseCaseInterface) {
        self.post = post
        self.fetchUserUseCase = fetchUserUseCase
    }
    
    func fetchUserDetails() {
        state = .loading
        
        fetchUserUseCase.execute(userId: post.userId)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                let details = PostDetails(post: self.post, user: user)
                self.state = .loaded(postDetails: details)
            }
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: PostError) {
        let message: String
        switch error {
        case .networkError:
            message = "Network connection error. Please try again."
        case .decodingError:
            message = "Unable to process the user data. Please try again."
        case .invalidURL:
            message = "Invalid URL configuration."
        case .unknown(let underlyingError):
            message = underlyingError.localizedDescription
        }
        state = .error(message)
    }
}
