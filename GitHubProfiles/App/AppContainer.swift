//
//  AppContainer.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

struct AppContainer: Sendable {
    let apiClient: any APIClient
    let githubService: any GitHubServiceProtocol
    let githubRepository: any GitHubRepositoryProtocol

    init() {
        let apiClient = GitHubAPIClient()
        let githubService = GitHubService(apiClient: apiClient)
        let githubRepository = GitHubRepository(service: githubService)
        
        self.apiClient = apiClient
        self.githubService = githubService
        self.githubRepository = githubRepository
    }

    @MainActor
    func makeUserSearchViewModel() -> UserSearchViewModel {
        UserSearchViewModel(repository: githubRepository)
    }

    @MainActor
    func makeProfileViewModel(username: String) -> ProfileViewModel {
        ProfileViewModel(username: username,repository: githubRepository)
    }
}
