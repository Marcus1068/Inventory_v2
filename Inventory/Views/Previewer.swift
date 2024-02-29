/*

Copyright 2024 Marcus Deuß

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

*/

//
//  Previewer.swift


import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let event2: Event
    //let room: Room
    let inventory: Inventory
    let inventory2: Inventory

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Inventory.self, configurations: config)

        //room = Room(name: "Living Room", symbol: "sofa")
        event = Event(name: "Event 1", location: "Hamburg")
        inventory = Inventory(name: "Steve Rogers", emailAddress: "steve@parker.com", details: "", metAt: event)
        event2 = Event(name: "Event 2", location: "Berlin")
        inventory2 = Inventory(name: "Peter Parker", emailAddress: "peter@parker.com", details: "", metAt: event2)

        container.mainContext.insert(inventory)
        container.mainContext.insert(inventory2)
    }
}
