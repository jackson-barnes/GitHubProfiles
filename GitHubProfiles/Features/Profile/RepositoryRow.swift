//
//  RepositoryRow.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(repository.name)
                .font(.headline)

            if let description = repository.description,
               !description.isEmpty {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }

            repositoryMetadata
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var repositoryMetadata: some View {
        HStack(spacing: 16) {
            if let language = repository.language {
                Label(language, systemImage: "circle.fill")
            }

            Label(repository.stargazersCount.formatted(), systemImage: "star")
            
            Label(repository.forksCount.formatted(), systemImage: "tuningfork")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}
