//
//  PListManager.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 07/01/2025.
//

import Foundation

struct ConfigData: Codable {
    let clientId: String
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
    }
}

class ConfigurationManager {
    
    static var instance = ConfigurationManager()
    
    internal let plistDictionnary: ConfigData
    
    init() {
        guard let url = Bundle.main.url(forResource: "environment", withExtension: "plist") 
                else {
                    fatalError("Could not find environment.plist file in the bundle.")
                }
            do {
                let data = try Data(contentsOf: url)
                let result = try PropertyListDecoder().decode(ConfigData.self, from: data)
                self.plistDictionnary = result
            } catch { fatalError("Could not boot app without configuration plist") }
    }
}
