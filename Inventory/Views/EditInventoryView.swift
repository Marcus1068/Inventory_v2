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

//  EditInventoryView.swift


import PhotosUI
import SwiftData
import SwiftUI

struct EditInventoryView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var inventory: Inventory
    @Binding var navigationPath: NavigationPath
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedItem2: PhotosPickerItem?

    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.3")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
            Spacer()
            
            Form {
                Section("Photo of inventory") {
                    if let imageData = inventory.photo, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                    }
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("Select a photo", systemImage: "person")
                    }
                    
                }
                
                Section("2nd photo"){
                    if let imageData2 = inventory.photo2, let uiImage2 = UIImage(data: imageData2) {
                        Image(uiImage: uiImage2)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                    }
                    
                    PhotosPicker(selection: $selectedItem2, matching: .images) {
                        Label("Select a 2nd photo", systemImage: "person")
                    }
                }

                Section("Details") {
                    TextField("Name", text: $inventory.name)
                        .textContentType(.name)

                    TextField("Email address", text: $inventory.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                //.foregroundColor(.red)

                Section("Where did you meet them?") {
                    Picker("Met at", selection: $inventory.metAt) {
                        Text("Unknown event")
                            .tag(Optional<Event>.none)

                        if events.isEmpty == false {
                            Divider()

                            ForEach(events) { event in
                                Text(event.name)
                                    .tag(Optional(event))
                            }
                        }
                    }

                    Button("Add a new event", action: addEvent)
                }

                Section("Notes") {
                    TextField("Inventory details", text: $inventory.details, axis: .vertical)
                }
            }
            //.foregroundColor(.brown)
            .tint(.blue)
            .background(Color.secondary)
            .scrollContentBackground(.hidden)
            .navigationTitle("Edit Inventory")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Event.self) { event in
                EditEventView(event: event)
            }
        .onChange(of: selectedItem, loadPhoto)
        .onChange(of: selectedItem2, loadPhoto2)
        }
    }
    

    func addEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
        navigationPath.append(event)
    }

    func loadPhoto() {
        Task { @MainActor in
            inventory.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
    
    func loadPhoto2() {
        Task { @MainActor in
            inventory.photo2 = try await selectedItem2?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return EditInventoryView(inventory: previewer.inventory, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
