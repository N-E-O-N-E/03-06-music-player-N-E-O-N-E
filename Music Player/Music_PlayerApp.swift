import SwiftUI

@main
struct Music_PlayerApp: App {
    var body: some Scene {
        WindowGroup {
            
            
            TabView {
                
                NavigationStack {
                    ChartView()
                }
                .tabItem {
                    Label("Charts", systemImage: "music.note.list")
                }
                
                NavigationStack {
                    SearchView()
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            }
        }
    }
}

