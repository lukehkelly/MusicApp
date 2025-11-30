//
//  MainMenuView.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/29/25.
//

import SwiftUI

struct MainMenuView: View {
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
            }
        }
    }
}

#Preview {
    MainMenuView()
}
