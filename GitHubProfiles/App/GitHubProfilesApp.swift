//
//  GitHubProfilesApp.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 08/08/2026.
//

import SwiftUI

@main
struct GitHubProfilesApp: App {
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            UserSearchView(viewModel: container.makeUserSearchViewModel(), makeProfileViewModel: container.makeProfileViewModel)
        }
    }
}
