//
//  Podcast.swift
//  PlaygroundApp
//
//  Created by Lev Tseytlin on 26.08.21.
//

import UIKit

struct Podcast: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let detail: String
    let mp3Url: URL
    let imageUrl: URL
    
    init(name: String, detail: String, mp3Url: URL, imageUrl: URL) {
        self.name = name
        self.detail = detail
        self.mp3Url = mp3Url
        self.imageUrl = imageUrl
    }
    
}
