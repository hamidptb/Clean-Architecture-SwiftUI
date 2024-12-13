//
//  PostsViewModel.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Foundation
import Combine

final class PostsViewModel: ObservableObject {
    @Published private(set) var state = ViewState.idle
    
    private let fetchPostsUseCase: FetchPostsUseCaseInterface
    private var cancellables = Set<AnyCancellable>()
    
    enum ViewState {
        case idle
        case loading
        case loaded([Post])
        case error(String)
    }
    
    init(fetchPostsUseCase: FetchPostsUseCaseInterface) {
        self.fetchPostsUseCase = fetchPostsUseCase
    }
    
    func fetchPosts() {
        state = .loading
        
        fetchPostsUseCase.execute()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] posts in
                self?.state = .loaded(posts)
            }
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: PostError) {
        let message: String
        switch error {
        case .networkError:
            message = "Network connection error. Please try again."
        case .decodingError:
            message = "Unable to process the data. Please try again."
        case .invalidURL:
            message = "Invalid URL configuration."
        case .unknown(let underlyingError):
            message = underlyingError.localizedDescription
        }
        state = .error(message)
    }
}
