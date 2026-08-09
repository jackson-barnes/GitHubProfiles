//
//  ProfileViewModel.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Observation

@MainActor
@Observable
final class ProfileViewModel {
    private let repository: any GitHubRepositoryProtocol

    let username: String

    private(set) var user: User?
    private(set) var repositories: [Repository] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    init(username: String, repository: any GitHubRepositoryProtocol) {
        self.username = username
        self.repository = repository
    }

    func load() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        do {
            async let user = repository.fetchUser(username: username)
            async let repositories = repository.fetchRepositories(username: username)
            
            let (fetchedUser, fetchedRepositories) = try await (user, repositories)

            self.user = fetchedUser
            self.repositories = fetchedRepositories
            isLoading = false
        } catch is CancellationError {
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Unable to load this GitHub profile."
        }
    }
}
