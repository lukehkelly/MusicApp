//
//  ContentView.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var albums: [Album] = []
    @State private var searchText = "Massive Shoe"
    
    private let albumService = AlbumService()
    
    var body: some View {
        NavigationStack {
            List(albums) { album in
                VStack(alignment: .leading) {
                    Text(album.name)
                    Text(album.artist)
                }
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            performSearch()
        }
        .task {
            performSearch()
        }
    }
    
    func performSearch() {
        Task {
            do {
                let results = try await albumService.searchForAlbums(search: searchText)
                
                await MainActor.run {
                    self.albums = results
                }
            } catch {
                print("Error fetching albums")
            }
        }
    }
}

#Preview {
    ContentView()
}
