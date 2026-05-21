//
//  BoardItem.swift
//  ConnectFourTutorial
//
//  Created by Sreejith, Shriya (Student) on 2/25/26.
//

import UIKit

enum Tile{
    case Red, Yellow, Empty
}

struct BoardItem {
    
    var indexPath: IndexPath!
    var tile: Tile!
    
    func emptyTile() -> Bool {
        return tile == Tile.Empty
    }
    func redTile() -> Bool {
        return tile == Tile.Red
    }
    func yellowTile() -> Bool {
        return tile == Tile.Yellow
    }
    func tileColor() -> UIColor {
        if redTile() {
            return .red
        } else if yellowTile() {
            return .yellow
        }
        return .white
    }
}
