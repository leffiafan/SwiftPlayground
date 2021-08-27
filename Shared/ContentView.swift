//
//  ContentView.swift
//  PlaygroundApp
//
//  Created by Lev Tseytlin on 26.08.21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var radioPlayer: RadioPlayer
    
    var body: some View {
        if (radioPlayer.loading) {
            Text("Loading...")
        } else {
            NavigationView {
                List(radioPlayer.podcasts.indices) { index in
                    HStack {
                        Button(action: {
                            radioPlayer.podcastIndex = index
                            print(radioPlayer.podcasts[radioPlayer.podcastIndex].imageUrl)
                        }) {
                            HStack {
                                AsyncImage(
                                    url: radioPlayer.podcasts[index].imageUrl,
                                    placeholder: {
                                        Text("Loading...")
                                    },
                                    image: { Image(uiImage: $0).resizable() }
                                )
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                Text(radioPlayer.podcasts[index].name)
                            }
                        }
                    }
                }
                .navigationTitle("Digital X Radio original Podcasts")
                .navigationBarTitleDisplayMode(.inline)
            }
            VStack {
                HStack {
                    AsyncImage(
                        url: radioPlayer.podcasts[radioPlayer.podcastIndex].imageUrl,
                        placeholder: {
                            Text("Loading...")
                        },
                        image: { Image(uiImage: $0).resizable() }
                    )
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    Text(radioPlayer.podcasts[radioPlayer.podcastIndex].name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let state = RadioPlayer()
        ContentView()
            .environmentObject(state)
    }
}
