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
//  EventListView.swift

//  Created by Marcus Deuß on 25.02.24.
//

import SwiftUI
import SwiftData

struct EventListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @Query var events: [Event]
    
    var body: some View {
        NavigationStack(path: $path) {
            List{
                ForEach(events, id: \.self) { event in
                    NavigationLink(event.name, value: event)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(event.location)
                        .font(.subheadline)
                }
                .onDelete(perform: deleteEvent)
            }
            .navigationDestination(for: Event.self) { event in
                EditEventView(event: event)
            }
            .navigationTitle("Select an event")
        }
    }
    
    func deleteEvent(at offsets: IndexSet) {
        for offset in offsets {
            let event = events[offset]
            modelContext.delete(event)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return EventListView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
