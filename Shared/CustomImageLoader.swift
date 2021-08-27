//
//  CustomImageLoader.swift
//  PlaygroundApp
//
//  Created by Lev Tseytlin on 25.08.21.
//

import SwiftUI

class CustomImageLoader: ObservableObject {

    @Published var dataIsValid = false
    var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
                self.data = data
            }
        }
        task.resume()
    }
}
