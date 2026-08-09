//
//  Repository.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

struct Repository: Decodable, Identifiable, Sendable {
    let id: Int
    let name: String
    let fullName: String
    let htmlUrl: URL
    let description: String?
    let language: String?
    let stargazersCount: Int
    let forksCount: Int
}
