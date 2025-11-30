//
//  ContentView.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/18/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State private var albums: [Album] = []
    @State private var searchText = ""
    
    private let albumService = AlbumService()
    
    var body: some View {
        List(albums) { album in
            VStack(alignment: .leading) {
                Text(album.name)
                Text(album.artist)
            }
            .swipeActions(edge: .leading) {
                Button {
                    dataManager.addToLogged(album)
                } label: {
                    Label("Log", systemImage: "checkmark" )
                }
                .tint(.green)
                Button {
                    dataManager.addToListenLater(album)
                } label: {
                    Label("Listen Later", systemImage: "clock" )
                }
                .tint(.orange)
            }
        }
        
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            performSearch()
        }
        .task {
            performSearch()
        }
        .navigationTitle("Album Search")
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

