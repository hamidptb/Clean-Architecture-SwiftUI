//
//  UserRepositoryInterface.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import Combine

protocol UserRepositoryInterface {
    func fetchUser(id: Int) -> AnyPublisher<User, PostError>
}
