//
//  RepositoryWebView.swift
//  GitHubProfiles
//
//  Created by Jackson Barnes on 09/08/2026.
//

import SwiftUI
import WebKit

struct RepositoryWebView: View {
    let repository: Repository

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {
        NavigationStack {
            RepositoryWebViewRepresentable(url: repository.htmlUrl)
            .navigationTitle(repository.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

private struct RepositoryWebViewRepresentable: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    func updateUIView(_ webView: WKWebView,context: Context) {
        guard webView.url != url else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
