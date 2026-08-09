//
//  GitHubRepository.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

struct GitHubRepository: GitHubRepositoryProtocol {
    private let service: any GitHubServiceProtocol
    
    init(service: any GitHubServiceProtocol) {
        self.service = service
    }
    
    func searchUsers(query: String) async throws -> [UserSearchResult] {
        try await service.searchUsers(query: query)
    }
    
    func fetchUser(username: String) async throws -> User {
        try await service.fetchUser(username: username)
    }
    
    func fetchRepositories(username: String) async throws -> [Repository] {
        try await service.fetchRepositories(username: username)
    }
}
