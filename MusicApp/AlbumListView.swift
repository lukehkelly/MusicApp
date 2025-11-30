//
//  AlbumListView.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/30/25.
//

import SwiftUI

struct AlbumListView: View {
    let title: String
    let albums: [Album]
    
    var body: some View {
        List(albums) { album in
            VStack(alignment: .leading) {
                Text(album.name)
                    .font(.headline)
                Text(album.artist)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(title)
        .overlay {
            if albums.isEmpty {
                ContentUnavailableView(
                    "No albums yet",
                    systemImage: "music.note.list",
                    description: Text("Go to Search or Recommendations to add an album"))
            }
        }
    }
}
