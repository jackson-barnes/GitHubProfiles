//
//  UserSearchResult.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

struct UserSearchResult: Decodable, Identifiable, Sendable {
    let id: Int
    let login: String
    let avatarUrl: URL
    let type: AccountType

    enum AccountType: Decodable, Sendable {
        case user
        case organization
        case unknown(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)

            switch value {
            case "User":
                self = .user

            case "Organization":
                self = .organization

            default:
                self = .unknown(value)
            }
        }
    }
}
