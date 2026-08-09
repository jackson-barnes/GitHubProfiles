//
//  ProfileView.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel: ProfileViewModel
    @State private var selectedRepository: Repository?

    init(viewModel: ProfileViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        content
            .navigationTitle(viewModel.username)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.load()
            }
            .sheet(item: $selectedRepository) { repository in
                RepositoryWebView(repository: repository)
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.user == nil {
            ProgressView("Loading profile...")
        } else if let errorMessage = viewModel.errorMessage {
            errorView(message: errorMessage)
        } else if let user = viewModel.user {
            profileContent(user: user)
        } else {
            ContentUnavailableView("Profile Unavailable", systemImage: "person.crop.circle")
        }
    }

    private func profileContent(user: User) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ProfileHeaderView(user: user)
                repositorySection
            }
            .padding()
        }
    }

    private var repositorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Repositories")
                .font(.title2)
                .fontWeight(.bold)

            if viewModel.repositories.isEmpty {
                Text("No public repositories.")
                    .foregroundStyle(.secondary)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.repositories) { repository in
                        Button {
                            selectedRepository = repository
                        } label: {
                            RepositoryRow(repository: repository)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private func errorView(message: String) -> some View {
        ContentUnavailableView("Something Went Wrong", systemImage: "exclamationmark.triangle", description: Text(message))
    }
}
