//
//  Event.swift
//
//  Created by Marcus Deuß on 25/02/2024.
//

import Foundation
import SwiftData

@Model
class Event{
    var name: String = ""
    var location: String = ""
    
    //relations
    var inventory: [Inventory]? = [Inventory]()

    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
