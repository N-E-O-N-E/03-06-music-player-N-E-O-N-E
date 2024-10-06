//
//  SearchView.swift
//  Music Player
//
//  Created by Markus Wirtz on 01.10.24.
//

import SwiftUI

struct SearchView: View {
    @State private var textSearchInput: String = ""
    @State private var searchResult: [SearchResult] = []
    
    var body: some View {
        
        VStack(alignment:.leading) {
            Text("Search Songs").font(.title).bold()
                .padding()
            
            HStack {
                TextField("Search", text: $textSearchInput)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                
                Button("Suche") {
                    Task {
                        do {
                            try await searchITunes(search: textSearchInput)
                        } catch {
                            print(Errors.invalidData, error)
                        }
                        textSearchInput = ""
                        textSearchInput = ""
                    }
                    
                }.padding(15)
            }
            SearchViewList(searchResult: searchResult)
        }
        Spacer()
    }
    func searchITunes(search: String) async throws {
        
        let newSearch = search.replacingOccurrences(of: " ", with: "+")
        
        // daten holen
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(newSearch)&entity=song") else {
            throw Errors.invalidURL
        }
        
        // daten umwandeln
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //daten decodieren
        let result = try JSONDecoder().decode(SearchResponse.self, from: data)
        self.searchResult.removeAll()
        self.searchResult = result.results
    }
}

#Preview {
    SearchView()
}
