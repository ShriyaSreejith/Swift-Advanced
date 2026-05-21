//
//  FavoritesView.swift
//  OutfitPicker
//
//  Created by Sreejith, Shriya (Student) on 2/20/26.
//

import SwiftUI

struct FavoritesView: View{
    
    @EnvironmentObject var model: OutfitModel
    
    var body: some View{
        NavigationView{
            List{
                ForEach(model.favorites, id: \.self) { item in
                    Text(item)
                }
                .onDelete { indexSet in
                    model.favorites.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Favorites ❤️")
        }
    }
}
