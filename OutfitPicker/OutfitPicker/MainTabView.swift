//
//  MainTabView.swift
//  OutfitPicker
//
//  Created by Sreejith, Shriya (Student) on 2/20/26.
//

import SwiftUI

struct MainTabView: View{
    
    var body: some View{
        TabView{
            
            ClosetView()
                .tabItem {
                    Label("Closet", systemImage: "hanger")
                }
            GenerateView()
                .tabItem {
                    Label("Generate", systemImage: "dice")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}
