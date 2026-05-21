//
//  HomeView.swift
//  OutfitPicker
//
//  Created by Sreejith, Shriya (Student) on 2/20/26.
//

import SwiftUI

struct HomeView: View{
    
    @Binding var showMainApp: Bool
    
    var body: some View{
        VStack(spacing: 30) {
            
            Spacer()
            
            Image(systemName: "tshirt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
            
            Text("Outfit Picker")
                .font(.largeTitle)
                .bold()
            Spacer()
            Button("Enter Closet 👗") {
                showMainApp = true
            }
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
}
