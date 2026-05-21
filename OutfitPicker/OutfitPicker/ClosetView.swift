//
//  ClosetView.swift
//  OutfitPicker
//
//  Created by Sreejith, Shriya (Student) on 2/20/26.
//

import SwiftUI

struct ClosetView: View {
    
    @EnvironmentObject var model: OutfitModel
    
    @State private var newTop = ""
    @State private var newBottom = ""
    @State private var newShoe = ""
    
    var body: some View{
        NavigationView{
            ScrollView {
                VStack(spacing: 25){
                    
                    
                    VStack(alignment: .leading) {
                        Text("Tops")
                            .font(.headline)
                        
                        TextField("Enter top", text: $newTop)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Add Top"){
                            if !newTop.isEmpty {
                                model.tops.append(newTop)
                                newTop = ""
                            }
                        }
                        
                        ForEach(model.tops, id: \.self){ top in
                            Text("• \(top)")
                        }
                    }
                    
                    Divider()
                    
                    
                    VStack(alignment: .leading){
                        Text("Bottoms")
                            .font(.headline)
                        
                        TextField("Enter bottom", text: $newBottom)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Add Bottom"){
                            if !newBottom.isEmpty{
                                model.bottoms.append(newBottom)
                                newBottom = ""
                            }
                        }
                        
                        ForEach(model.bottoms, id: \.self){ bottom in
                            Text("• \(bottom)")
                        }
                    }
                    
                    Divider()
                    
                    
                    VStack(alignment: .leading) {
                        Text("Shoes")
                            .font(.headline)
                        
                        TextField("Enter shoes", text: $newShoe)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Add Shoes") {
                            if !newShoe.isEmpty{
                                model.shoes.append(newShoe)
                                newShoe = ""
                            }
                        }
                        
                        ForEach(model.shoes, id: \.self){ shoe in
                            Text("• \(shoe)")
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("My Closet 👗")
        }
    }
}
