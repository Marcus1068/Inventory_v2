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

import SwiftData
import SwiftUI

struct InventoryListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()

    @State private var sortOrder = [SortDescriptor(\Inventory.name)]
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $path) {
            InventoryView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("Inventory App")
                .navigationDestination(for: Inventory.self) { inv in
                    EditInventoryView(inventory: inv, navigationPath: $path)
                }
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([SortDescriptor(\Inventory.name)])

                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Inventory.name, order: .reverse)])
                        }
                    }

                    Button("Add inventory", systemImage: "plus", action: addInventory)
                }
                .searchable(text: $searchText)
        }
    }

    func addInventory() {
        let inv = Inventory(name: "", emailAddress: "", details: "")
        modelContext.insert(inv)
        path.append(inv)
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return InventoryListView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
