//
//  SearchView.swift
//  Music Player
//
//  Created by Markus Wirtz on 01.10.24.
//

import SwiftUI

struct SearchView: View {
    @State private var textSearchInput: String = ""
    @State private var newSearchString: String = ""
    @State private var link: String = ""
    @State private var searchResult: [SearchResult] = []
    
    var body: some View {
        
        VStack(alignment:.leading) {
            ZStack (alignment: .bottom) {
                
                Image("cat")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .frame(width: 405, height: 280)
                    .opacity(0.89)
                
                VStack(alignment:.leading) {
                    Text("Search Artists/Songs")
                        .font(.title).bold()
                        .foregroundStyle(.white)
                        .shadow(color: .purple, radius: 20)
                        .padding(10)
                    
                    HStack {
                        TextField("Search", text: $textSearchInput)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 10)
                        
                        Button {
                            Task {
                                do {
                                    newSearchString = textSearchInput.replacingOccurrences(of: " ", with: "+").lowercased()
                                    link = "https://itunes.apple.com/search?term=\(newSearchString)&entity=song&country=DE"
                                    searchResult.removeAll()
                                    try await searchITunes(link: link)
                                } catch {
                                    print(Errors.invalidData, error)
                                }
                            }
                        } label: {
                            Text("Suche")
                                .frame(width: 120, height: 35)
                                .background(Color(hue: 0.8, saturation: 0.9, brightness: 0.4))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .purple, radius: 10)
                                
                        }
                    }
                }.padding(20)
            }
        }
        
        SearchViewList(searchResult: searchResult)
        
        Spacer()
    }
    func searchITunes(link: String ) async throws {
        
        guard let url = URL(string: link) else {
            throw Errors.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw Errors.invalidData
            }
            
            let result = try JSONDecoder().decode(SearchResponse.self, from: data)
            self.searchResult = result.results
            
        } catch {
            print("Fehler bei der Datenverarbeitung:", error)
            throw error
        }
    }
}

#Preview {
    SearchView()
}
