//
//  Models.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/19/25.
//

import Foundation

struct Album: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case url
    }
}

struct AlbumMatches: Decodable {
    let albums: [Album]
    
    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
}

struct SearchResults: Decodable {
    let albumMatches: AlbumMatches
    
    enum CodingKeys: String, CodingKey {
        case albumMatches = "albummatches"
    }
}

struct AlbumSearchResponse: Decodable {
    let results: SearchResults
}
