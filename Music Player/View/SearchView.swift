//
//  SearchView.swift
//  Music Player
//
//  Created by Markus Wirtz on 01.10.24.
//

import SwiftUI

struct SearchView: View {
    @State private var textSearch: String = ""
    @State private var searchResult: [SearchResult] = []
    
    
    var body: some View {
        
        VStack(alignment:.leading) {
            Text("Charts Top 50").font(.title).bold()
                .padding()
            
            HStack {
                TextField("Search", text: $textSearch)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                
                Button("Suche") {
                    
                }.padding(15)
                
            }
            
            List(searchResult, id:\.trackID) { search in
                VStack(alignment: .leading) {
                    Text(search.trackName ?? "unknown")
                        .frame(width: 260, alignment: .leading)
                        .font(.title3)
                        .foregroundStyle(.black)
                        .bold()
                }.padding(10)
            }
        }
        Spacer()
    }
    
    
    private func DataAndJsonDecoder() async throws {
        
        // Daten entgegennehmen
        guard let path = URL(string: "https://itunes.apple.com/search?term=SongName&media=music&limit=200") else {
            throw Errors.invalidURL
        }
        
        // Daten auslesen
        let (data, _) = try await URLSession.shared.data(from: path)
        
        // Daten umwandeln (decodieren)
        let songs = try JSONDecoder().decode(SearchResponse.self, from: data)
        
        //self.searchResult = songs.result!
        
    }
}

#Preview {
    SearchView()
}