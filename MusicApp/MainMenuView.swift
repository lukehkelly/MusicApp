//
//  MainMenuView.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/29/25.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var dataManager: DataManager
    
    let darkGray = Color(red: 0.12, green: 0.12, blue: 0.12)
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                darkGray
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Image(systemName: "music.note.house.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Text("TuneTracker")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    
                    HStack (spacing: 15){
                        // search button
                        NavigationLink(destination: SearchView()) {
                            MenuButton(
                                title: "Search Albums", color: .blue, icon: "magnifyingglass", height: 120)
                        }
                        // recommendations button
                        NavigationLink(destination: RecommendationView()) {
                            MenuButton(
                                title: "Recommendations", color: .yellow, icon: "arrow.triangle.2.circlepath", height: 120)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        // Logged albums
                        NavigationLink(destination: AlbumListView(title: "Logged Albums", albums: $dataManager.loggedAlbums)) {
                            MenuButton(title: "Logged Albums", color: .green, icon: "checkmark.circle.fill", height: 80)
                        }
                        .padding(.bottom, 15)
                        
                        // Listen later
                        NavigationLink(destination: AlbumListView(title: "Listen Later", albums: $dataManager.listenLaterAlbums)) {
                            MenuButton(title: "Listen Later", color: .orange, icon: "clock.fill", height: 80)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    struct MenuButton: View {
        let title: String
        let color: Color
        let icon: String
        let height: CGFloat
        
        var body: some View {
            VStack(spacing: 10){
                Image(systemName: icon)
                    .font(.system(size: 30))
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(color.gradient)
            .foregroundColor(.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
        }
    }
}

#Preview {
    MainMenuView()
        .environmentObject(DataManager())
}
