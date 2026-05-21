//
//  GenerateView.swift
//  OutfitPicker
//
//  Created by Sreejith, Shriya (Student) on 2/20/26.
//

import SwiftUI

struct GenerateView: View {
    
    @EnvironmentObject var model: OutfitModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button("Generate Outfit 🎲") {
                model.generateOutfit()
            }
            .font(.title2)
            
            if !model.selectedTop.isEmpty {
                
                Text("Top: \(model.selectedTop)")
                Text("Bottom: \(model.selectedBottom)")
                Text("Shoes: \(model.selectedShoe)")
                
                Button("Save ❤️") {
                    let outfit = "\(model.selectedTop), \(model.selectedBottom), \(model.selectedShoe)"
                    model.favorites.append(outfit)
                }
            }
        }
        .padding()
    }
}
