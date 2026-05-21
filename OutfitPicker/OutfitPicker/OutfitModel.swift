//
//  OutfitModel.swift
//  OutfitPicker
//
//  Created by Sreejith, Shriya (Student) on 2/20/26.
//

import Foundation
import SwiftUI
import Combine

class OutfitModel: ObservableObject{
    
    @Published var tops: [String] = []
    @Published var bottoms: [String] = []
    @Published var shoes: [String] = []
    @Published var favorites: [String] = []
    @Published var selectedTop = ""
    @Published var selectedBottom = ""
    @Published var selectedShoe = ""
    
    func generateOutfit(){
        if let top = tops.randomElement(),
           let bottom = bottoms.randomElement(),
           let shoe = shoes.randomElement() {
            
            selectedTop = top
            selectedBottom = bottom
            selectedShoe = shoe
        }
    }
}
