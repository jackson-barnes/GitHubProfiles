//
//  GitHubService.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

struct GitHubService: GitHubServiceProtocol {
    private let apiClient: any APIClient

    init(apiClient: any APIClient) {
        self.apiClient = apiClient
    }

    func searchUsers(query: String) async throws -> [UserSearchResult] {
        let response: UserSearchResponse = try await apiClient.send(.searchUsers(query: query))
        return response.items
    }

    func fetchUser(username: String) async throws -> User {
        try await apiClient.send(.user(username: username))
    }

    func fetchRepositories(username: String) async throws -> [Repository] {
        try await apiClient.send(.repositories(username: username))
    }
}
