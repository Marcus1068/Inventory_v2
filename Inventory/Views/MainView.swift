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
//  MainView.swift
//
//  Created by Marcus Deuß on 23.02.24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("First", systemImage: "list.dash")
                }

            EventView()
                .tabItem {
                    Label("Events", systemImage: "light.cylindrical.ceiling.inverse")
                }
            
            AboutView()
                .tabItem {
                    Label("Second", systemImage: "figure.racquetball")
                }
        }
    }
}

#Preview {
    MainView()
}