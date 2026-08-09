//
//  APIEndpoint.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

enum APIEndpoint: Sendable {
    case searchUsers(query: String)
    case user(username: String)
    case repositories(username: String)
    
    private static let baseURL = URL(string: "https://api.github.com")
    
    func makeRequest() throws -> URLRequest {
        guard let baseURL = Self.baseURL else {
            throw APIError.invalidURL
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        
        switch self {
        case .searchUsers(let query):
            components?.path = "/search/users"
            components?.queryItems = [URLQueryItem(name: "q", value: query)]
            
        case .user(let username):
            components?.path = "/users/\(username)"
            
        case .repositories(let username):
            components?.path = "/users/\(username)/repos"
            components?.queryItems = [URLQueryItem(name: "sort", value: "stars"), URLQueryItem(name: "per_page", value: "30")]
        }
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("GitHubProfiles", forHTTPHeaderField: "User-Agent")
        
        return request
    }
}
