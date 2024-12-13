//
//  PostDetailView.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject private var viewModel: PostDetailViewModel
    
    init(post: Post) {
        _viewModel = StateObject(wrappedValue: DependencyContainer.shared.makePostDetailViewModel(post: post))
    }
    
    var body: some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchUserDetails()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        
        case .loaded(let details):
            if let details = details {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        postContent(details)
                        userContent(details)
                    }
                    .padding()
                }
            }
            
        case .error(let message):
            ErrorView(message: message) {
                viewModel.fetchUserDetails()
            }
        }
    }
    
    private func postContent(_ details: PostDetailViewModel.PostDetails) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(details.post.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(details.post.body)
                .font(.body)
        }
    }
    
    private func userContent(_ details: PostDetailViewModel.PostDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Author Details")
                .font(.headline)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Name: \(details.user.name)")
                Text("Username: @\(details.user.username)")
                Text("Email: \(details.user.email)")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}
