//
//  MainMenuView.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/29/25.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
                Image(systemName: "music.note.house.fill")
                Spacer().frame(height: 30)
                
                // search button
                NavigationLink(destination: SearchView()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search Albums")
                    }
                }
                // recommendations button
                NavigationLink(destination: RecommendationView()) {
                    HStack {
                        Image(systemName: "book")
                        Text("Recommendations")
                    }
                }
                Divider().padding(.vertical)
                
                // Logged albums
                NavigationLink(destination: AlbumListView(title: "Logged Albums", albums: dataManager.loggedAlbums)) {
                    MenuButton(title: "Logged Albums", color: .green)
                }
                
                // Listen later
                NavigationLink(destination: AlbumListView(title: "Listen Later", albums: dataManager.listenLaterAlbums)) {
                    MenuButton(title: "Listen Later", color: .orange)
                }
            }
        }
    }
}

struct MenuButton: View {
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: 300)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    MainMenuView()
        .environmentObject(DataManager())
}
