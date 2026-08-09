//
//  User.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

struct User: Decodable, Identifiable, Sendable {
    let id: Int
    let login: String
    let name: String?
    let avatarUrl: URL
    let bio: String?
    let followers: Int
    let following: Int
}
