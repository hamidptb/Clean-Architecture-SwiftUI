//
//  PostRepositoryInterface.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Combine

protocol PostRepositoryInterface {
    func fetchPosts() -> AnyPublisher<[Post], PostError>
}
