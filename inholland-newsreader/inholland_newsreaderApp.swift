//
//  inholland_newsreaderApp.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 05/10/2021.
//

import SwiftUI

@main
struct inholland_newsreaderApp: App {
    @ObservedObject var newsReaderAPI: NewsReaderAPI = NewsReaderAPI.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    ContentView()
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                NavigationView {
                    FavoritesView()
                }
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            }
        }
    }
}
