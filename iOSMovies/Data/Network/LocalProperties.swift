//
//  LocalProperties.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 13/03/24.
//

import Foundation

class LocalProperties {
    
    init() { }
    
    func getApiKey() -> String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            fatalError("Config.plist not found")
        }

        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load Config.plist")
        }
        
        do {
            let plistDecoder = PropertyListDecoder()
            let config = try plistDecoder.decode(Config.self, from: data)
            let apiKey = config.apiKey
            
            return apiKey
        } catch {
            fatalError("Error decoding Config.plist: \(error)")
        }
    }
}

struct Config: Decodable {
    let apiKey: String
    enum CodingKeys: String, CodingKey {
        case apiKey = "ApiKey"
    }
}
