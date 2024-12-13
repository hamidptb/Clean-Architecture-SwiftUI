//
//  ContentView.swift
//  Clean Architecture SwiftUI
//
//  Created by Hamid on 12/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: PostsViewModel
    
    init(viewModel: PostsViewModel = DependencyContainer.shared.makePostsViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Posts")
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .loaded(let posts):
            PostListView(posts: posts)
        case .error(let message):
            ErrorView(message: message) {
                viewModel.fetchPosts()
            }
        }
    }
}

struct PostListView: View {
    let posts: [Post]
    
    var body: some View {
        List(posts) { post in
            NavigationLink(destination: PostDetailView(post: post)) {
                PostRowView(post: post)
            }
        }
    }
}

struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .font(.headline)
            Text(post.body)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Error: \(message)")
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Retry") {
                retryAction()
            }
        }
    }
}
