import SwiftUI

@main
struct Music_PlayerApp: App {
    
    var body: some Scene {
        WindowGroup {
            
            
            TabView {
                
                Tab("Charts", systemImage: "music.note.list") {
                    ChartView()
                }
                
                Tab("Search", systemImage: "magnifyingglass") {
                    SearchView()
                }
            }
        }
    }
}

