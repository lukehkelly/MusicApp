//
//  DataManager.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/30/25.
//

import SwiftUI

class DataManager: ObservableObject {
    @Published var loggedAlbums: [Album] = []
    @Published var listenLaterAlbums: [Album] = []
    
    func addToLogged(_ album: Album) {
        if !loggedAlbums.contains(where: {$0.name == album.name && $0.artist == album.artist}) {
            loggedAlbums.append(album)
        }
    }
    
    func addToListenLater(_ album: Album) {
        if !listenLaterAlbums.contains(where: {$0.name == album.name && $0.artist == album.artist}) {
            listenLaterAlbums.append(album)
        }
    }
}
