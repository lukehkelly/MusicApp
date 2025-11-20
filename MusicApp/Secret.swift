//
//  Secret.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/20/25.
//

import Foundation

struct Secret {
    static var apiKey: String {
        
        guard let path = Bundle.main.path(forResource: "keys", ofType: "plist") else {
            print("keys.plist not found")
            return ""
        }
        
        let keys = NSDictionary(contentsOfFile: path)
        
        guard let apiKey = keys?["lastFMKey"] as? String else {
            print("lastFMKey not found in keys.plist")
            return ""
        }
        
        return apiKey
    }
}
