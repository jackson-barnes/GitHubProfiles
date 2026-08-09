//
//  APIError.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

enum APIError: Error, Sendable {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError
    case networkError
}
