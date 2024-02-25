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

//  InventoryView.swift


import SwiftData
import SwiftUI

struct InventoryView: View {
    @Environment(\.modelContext) var modelContext
    @Query var inventory: [Inventory]

    var body: some View {
        List {
            ForEach(inventory) { inv in
                NavigationLink(value: inv) {
                    VStack{
                        Text(inv.name)
                        if let imageData = inv.photo, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                    }
                }
            }
            .onDelete(perform: deleteInventory)
        }
    }

    init(searchString: String = "", sortOrder: [SortDescriptor<Inventory>] = []) {
        _inventory = Query(filter: #Predicate { inv in
            if searchString.isEmpty {
                true
            } else {
                inv.name.localizedStandardContains(searchString)
                || inv.emailAddress.localizedStandardContains(searchString)
                || inv.details.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }

    func deleteInventory(at offsets: IndexSet) {
        for offset in offsets {
            let person = inventory[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return InventoryView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

