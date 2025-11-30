//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by Luke Kelly on 11/18/25.
//

import SwiftUI

@main
struct MusicAppApp: App {
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environmentObject(dataManager)
        }
    }
}
