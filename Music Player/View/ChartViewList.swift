//
//  ChartViewList.swift
//  Music Player
//
//  Created by Markus Wirtz on 02.10.24.
//

import SwiftUI

struct ChartViewList: View {
    var songsResult: [Result] = []
    var textSearch: String = ""

    var body: some View {
        
        List(songsResult.filter { song in
            textSearch.isEmpty || song.name!.lowercased().contains(textSearch.lowercased()) },
             id:\.id) { song in
            
            HStack{
                AsyncImage(url: URL(string: song.artworkUrl100 ?? "cat")) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(.rect(cornerRadius: 8))
                    
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading) {
                    
                    Text(song.artistName ?? "no artist").bold()
                    Text(song.name ?? "no name").font(.subheadline)
                    Text(song.releaseDate ?? "no date").font(.caption).foregroundStyle(.gray)
                        
                }.padding(10)
            }
           
            
        }.listStyle(.plain)
    }
}

#Preview {
    ChartViewList(songsResult: testResult, textSearch: "")
}
