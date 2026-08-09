//
//  UserSearchViewModel.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Observation

@MainActor
@Observable
final class UserSearchViewModel {
    private let repository: any GitHubRepositoryProtocol

    private var searchTask: Task<Void, Never>?

    var query = "" {
        didSet {
            scheduleSearch()
        }
    }

    private(set) var users: [UserSearchResult] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    init(repository: any GitHubRepositoryProtocol) {
        self.repository = repository
    }

    private func scheduleSearch() {
        searchTask?.cancel()

        let query = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            users = []
            isLoading = false
            errorMessage = nil
            return
        }

        searchTask = Task { [weak self] in
            do {
                try await Task.sleep(for: .milliseconds(350))

                guard !Task.isCancelled else {
                    return
                }

                await self?.performSearch(query: query)
            } catch is CancellationError {
                // Expected when a new search is scheduled.
            } catch {
                // User-facing errors are handled by performSearch.
            }
        }
    }

    private func performSearch(query: String) async {
        guard !Task.isCancelled else {
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let users = try await repository.searchUsers(query: query)

            guard !Task.isCancelled else {
                return
            }

            guard query == self.query.trimmingCharacters(in: .whitespacesAndNewlines) else {
                return
            }

            self.users = users
            isLoading = false
        } catch is CancellationError {
            return
        } catch {
            guard !Task.isCancelled else {
                return
            }

            guard query == self.query.trimmingCharacters(in: .whitespacesAndNewlines) else {
                return
            }

            users = []
            isLoading = false
            errorMessage = "Unable to search GitHub. Please try again."
        }
    }
}
