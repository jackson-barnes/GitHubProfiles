//
//  ProfileHeaderView.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User

    var body: some View {
        VStack(spacing: 16) {
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
            .frame(width: 100, height: 100)
            .clipShape(Circle())

            VStack(spacing: 4) {
                if let name = user.name, !name.isEmpty {
                    Text(name)
                        .font(.title2)
                        .fontWeight(.bold)
                }

                Text("@\(user.login)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if let bio = user.bio, !bio.isEmpty {
                Text(bio)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }

            followerStats
        }
        .frame(maxWidth: .infinity)
    }

    private var followerStats: some View {
        HStack(spacing: 32) {
            statistic(value: user.followers, label: "Followers")
            statistic(value: user.following, label: "Following")
        }
    }

    private func statistic(value: Int, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value.formatted())
                .font(.headline)

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
