//
//  APIClient.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import Foundation

protocol APIClient: Sendable {
    func send<T: Decodable & Sendable>(_ endpoint: APIEndpoint) async throws -> T
}

struct GitHubAPIClient: APIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<T: Decodable & Sendable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = try endpoint.makeRequest()
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.httpError(statusCode: httpResponse.statusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError
        }
    }
}
