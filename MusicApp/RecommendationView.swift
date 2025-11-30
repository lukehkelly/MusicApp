//
//  RecommendationView.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/29/25.
//

import SwiftUI

struct RecommendationView: View {
    @EnvironmentObject var dataManager: DataManager
    
    let genres = ["rock", "pop", "alternative", "indie", "electronic", "dance", "00s", "jazz", "singer-songwriter", "metal", "soul", "80s", "folk", "british", "90s", "american", "instrumental", "punk", "blues", "rap", "hip-hop", "country", "70s", "funk", "60s", "rnb", "house", "reggae"].sorted()
    
    @State private var selectedGenre = "rock"
    @State private var albums: [Album] = []
    @State private var isLoading = false
    
    private var albumService = AlbumService()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 20) {
                HStack {
                    Text("Genre")
                        .fontWeight(.semibold)
                    
                    Picker("Select Genre", selection: $selectedGenre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre.capitalized).tag(genre)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.purple)
                }
                .padding(.top)
                
                Button(action: {
                    fetchRandomAlbums()
                }) {
                    HStack {
                        Image(systemName: "dice.fill")
                        Text("Randomize Recommendations")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(isLoading) // Prevent double clicking while loading
            }
            .padding()
            .background(Color(.systemGray6))
            
            if isLoading {
                Spacer()
                ProgressView("Finding albums...")
                Spacer()
            } else if albums.isEmpty {
                Spacer()
                ContentUnavailableView(
                    "No Albums Found",
                    systemImage: "music.note.list",
                    description: Text("Tap Randomize to find albums in \(selectedGenre.capitalized)")
                )
                Spacer()
            } else {
                List(albums) { album in
                    VStack(alignment: .leading) {
                        Text(album.name)
                            .font(.headline)
                        Text(album.artist)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
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
                .listStyle(.plain)
            }
        }
        .navigationTitle("Recommendations")
        .task {
            fetchTopAlbums()
        }
        .onChange(of: selectedGenre) {
            fetchTopAlbums()
        }
    }
    func fetchTopAlbums() {
        isLoading = true
        Task {
            do {
                let results = try await albumService.getTopAlbumsByTag(tag: selectedGenre)
                await MainActor.run {
                    self.albums = results
                    self.isLoading = false
                }
            } catch {
                print("Error fetching top albums: \(error)")
                await MainActor.run { self.isLoading = false }
            }
        }
    }
    
    func fetchRandomAlbums() {
        isLoading = true
        
        Task {
            do {
                // Call the function you wrote in AlbumService
                let results = try await albumService.getRandomAlbumsByTag(tag: selectedGenre)
                
                // Update UI
                await MainActor.run {
                    self.albums = results
                    self.isLoading = false
                }
            } catch {
                print("Error getting recommendations: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}
