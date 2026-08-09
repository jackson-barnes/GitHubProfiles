//
//  UserSearchResponse.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

struct UserSearchResponse: Decodable, Sendable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [UserSearchResult]
}
