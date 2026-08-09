//
//  GitHubRepositoryProtocol.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

protocol GitHubRepositoryProtocol: Sendable {
    func searchUsers(query: String) async throws -> [UserSearchResult]
    func fetchUser(username: String) async throws -> User
    func fetchRepositories(username: String) async throws -> [Repository]
}
