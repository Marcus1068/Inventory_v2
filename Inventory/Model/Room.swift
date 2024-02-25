//
//  Room.swift
//  Inventory
//
//  Created by Marcus Deuß on 25.02.24.
//

import Foundation
import SwiftData

@Model
class Room{
    var name: String
    var symbol: String
    
    var people: [Person]? = [Person]()
    
    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
    }
}
