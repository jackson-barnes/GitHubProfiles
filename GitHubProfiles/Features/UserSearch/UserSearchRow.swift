//
//  UserSearchRow.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import SwiftUI

struct UserSearchRow: View {
    let user: UserSearchResult

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: user.avatarUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()

                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(user.login)
                    .font(.headline)

                Text(accountTypeText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }

    private var accountTypeText: String {
        switch user.type {
        case .user:
            "User"

        case .organization:
            "Organization"

        case .unknown:
            "Unknown"
        }
    }
}
