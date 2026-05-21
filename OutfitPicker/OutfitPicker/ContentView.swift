//
//  ContentView.swift
//  OutfitPicker
//
//  Created by Sreejith, Shriya (Student) on 2/20/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model = OutfitModel()
    @State private var showMainApp = false
    
    var body: some View{
        
        if showMainApp{
            MainTabView()
                .environmentObject(model)   
        }else{
            HomeView(showMainApp: $showMainApp)
        }
    }
}
