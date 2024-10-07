//
//  ViewStart.swift
//  Music Player
//
//  Created by Markus Wirtz on 05.10.24.
//

import SwiftUI

struct ViewStart: View {
    var body: some View {
        
        TabView {
            Tab("Charts", systemImage: "music.note.list") {
                NavigationStack {
                    ChartView()
                }
            }
            
            Tab("Search", systemImage: "magnifyingglass") {
                NavigationStack {
                    SearchView()
                }
            }
        }
    }
}

#Preview {
    ViewStart()
}
