//
//  PlaygroundAppApp.swift
//  Shared
//
//  Created by Lev Tseytlin on 25.08.21.
//

import SwiftUI

@main
struct PlaygroundAppApp: App {
    
    var radioPlayer = RadioPlayer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(radioPlayer)
                .environment(\.colorScheme, .dark)
                .preferredColorScheme(.dark)
                .colorScheme(.dark)
        }
    }
}

class RadioPlayer: ObservableObject {
    
    @ObservedObject var podcastParser = PodcastParser()
    
    // List of podcasts
    @Published var podcasts: [Podcast] = []
    @Published var podcastIndex = 0
    @Published var loading = false
    
    init() {
        podcastParser.loadData()
        podcasts = podcastParser.podcasts
    }
    
}
