//
//  ContentView.swift
//  Shared
//
//  Created by Lev Tseytlin on 25.08.21.
//

import SwiftUI
import UIKit

class Parent: ObservableObject {
    @Published var children = [Child()]
}

class Child: ObservableObject {
    @Published var name: String?
    @Published var stations: [Station] = []
    @Published var imageUrl: String?

    func loadName() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Async task here...
            self.name = "Loaded name"
            self.stations.append(
                Station(
                    name: "Digital X Radio",
                    detail: "aus Frankfurt am Main",
                    url: URL(string: "https://s33.myradiostream.com:16253/listen.mp3")!,
                    image: nil,
                    imageUrl: ""
            ))
        }
    }
}

struct Station: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let detail: String
    let url: URL
    var image: UIImage?
    let imageUrl: String

    
    init(name: String, detail: String, url: URL, image: UIImage? = nil, imageUrl: String) {
        self.name = name
        self.detail = detail
        self.url = url
        self.image = image
        self.imageUrl = imageUrl
    }
    
}

struct FirstChildView: View {
    @ObservedObject var child: Child
    
    let imageLoader = CustomImageLoader(urlString: "https://d3t3ozftmdmh3i.cloudfront.net/production/podcast_uploaded_episode/10727944/10727944-1625208629654-9aa522985c51f.jpg")

    func imageFromData(_ data:Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }
    
    
    
    var body: some View {
        VStack {
            VStack {
                Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100, height:100)
                
                Image(uiImage: UIImage(systemName: "face.smiling")!)
            }
            Spacer()
            VStack {
                Text(child.stations.first?.name ?? "nil")
                    .onTapGesture {
                        self.child.loadName()
                    }
            }.debugAction {
                 
            }
        }
       
    }
}

struct ParentContentView: View {
    @ObservedObject var parent = Parent()

    var body: some View {
        // just for demo, in real might be conditional or other UI design
        // when no child is yet available
        FirstChildView(child: parent.children.first ?? Child())
    }
}

extension View {
    func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif

        return self
    }
    func debugPrint(_ value: Any) -> Self {
        debugAction { print(value) }
    }
}
