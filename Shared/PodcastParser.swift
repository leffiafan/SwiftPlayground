//
//  PodcastParser.swift
//  PlaygroundApp
//
//  Created by Lev Tseytlin on 26.08.21.
//

import SwiftUI

class PodcastParser: NSObject, XMLParserDelegate, ObservableObject {
            
    @Published var podcasts: [Podcast] = []
    @Published var loading = false

    
    var elementName: String = "ElementName"
    var podcastTitle: String  = "Title"
    var podcastURL: String = "URL"
    var podcastImageURL: String = "Image"
    
    func loadData() {
        
        self.loading = true
        
        guard let url:URL = URL(string: "https://") else {
            print("Error on create URL to read file")
            return
        }
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    let parser = XMLParser(data: data)
//                    parser.delegate = self
//                    parser.parse()
//                    self.loading = false
//                }
//            }
//        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            print("----> xml: \(String(data: data, encoding: .utf8))")
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
                self.loading = false
        }
        task.resume()
        
        /*if let parser = XMLParser(contentsOf: url) {
            parser.delegate = self
            parser.parse()
            self.loading = false
        }*/
    }
    
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            podcastTitle = String()
            podcastURL = String()
            podcastImageURL = String()
        }
        
        if elementName == "enclosure" {
            let attrsEnclosure = attributeDict as [String : NSString]
            podcastURL = String(attrsEnclosure["url"]!)
        }
        
        if elementName == "itunes:image" {
            let attrsImage = attributeDict as [String : NSString]
            podcastImageURL = String(attrsImage["href"]!)
        }
        
        self.elementName = elementName
        
    }
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            podcasts.append(
                Podcast(
                    name: podcastTitle,
                    detail: "Podcast",
                    mp3Url: URL(string: podcastURL)!,
                    imageUrl: URL(string: podcastImageURL)!
            ))
        }
        
    }
    
    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "title" {
                podcastTitle += data
            } else if self.elementName == "enclosure" {
                podcastURL += data
            } else if self.elementName == "itunes:image" {
                podcastImageURL += data
            }
        }
    }

}
