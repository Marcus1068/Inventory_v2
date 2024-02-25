//
//  Room.swift
//
//  Created by Marcus Deuß on 25.02.24.
//

import Foundation
import SwiftData

@Model
class Room{
    // room name
    var name: String = ""
    // sf symbol name of a room symbol like "sofa" or "bed.double"
    var symbol: String = ""
    
    var inventory: [Inventory]? = [Inventory]()
    
    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
    }
}
