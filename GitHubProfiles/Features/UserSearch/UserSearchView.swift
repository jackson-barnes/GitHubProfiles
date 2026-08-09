//
//  UserSearchView.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import SwiftUI

struct UserSearchView: View {
    @State private var viewModel: UserSearchViewModel

    private let makeProfileViewModel: @MainActor (String) -> ProfileViewModel

    init(viewModel: UserSearchViewModel, makeProfileViewModel: @escaping @MainActor (String) -> ProfileViewModel) {
        _viewModel = State(initialValue: viewModel)
        self.makeProfileViewModel = makeProfileViewModel
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("GitHub")
                .searchable(
                    text: $viewModel.query,
                    prompt: "Search GitHub users"
                )
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.users.isEmpty {
            ProgressView("Searching...")
        } else if let errorMessage = viewModel.errorMessage {
            errorView(message: errorMessage)
        } else if !viewModel.query.isEmpty && viewModel.users.isEmpty {
            ContentUnavailableView("No Users Found", systemImage: "person.crop.circle.badge.questionmark", description: Text("Try searching for a different username."))
        } else if viewModel.query.isEmpty {
            emptySearchView
        } else {
            userList
        }
    }

    private var userList: some View {
        List(viewModel.users) { user in
            NavigationLink {
                ProfileView(viewModel: makeProfileViewModel(user.login))
            } label: {
                UserSearchRow(user: user)
            }
        }
        .listStyle(.plain)
    }

    private var emptySearchView: some View {
        ContentUnavailableView("Search GitHub", systemImage: "magnifyingglass", description: Text("Search for a GitHub username to get started."))
    }

    private func errorView(message: String) -> some View {
        ContentUnavailableView("Something Went Wrong", systemImage: "exclamationmark.triangle", description: Text(message))
    }
}
