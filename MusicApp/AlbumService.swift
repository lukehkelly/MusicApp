//
//  AlbumService.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/20/25.
//

import Foundation

class AlbumService {
    
    private let apiKey = Secret.apiKey
    
    func searchForAlbums(search: String) async throws -> [Album] {
        
        var components = URLComponents(string: "https://ws.audioscrobbler.com/2.0/")
        components?.queryItems = [
            URLQueryItem(name: "method", value: "album.search"),
            URLQueryItem(name: "album", value: search),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "format", value: "json"),
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(AlbumSearchResponse.self, from: data)
            
            return decodedResponse.results.albumMatches.albums
        } catch {
            print("Decoding error: \(error)")
            throw error
        }
    }
}
