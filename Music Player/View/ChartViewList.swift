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
            textSearch.isEmpty || song.name!.lowercased().contains(textSearch.lowercased()) || song.artistName!.lowercased().contains(textSearch.lowercased())}, id:\.id) { song in
            
            HStack{
                
                VStack(alignment: .leading) {
                    
                    Text(song.artistName ?? "no artist").font(.title3).bold()
                    Text(song.name ?? "no name").font(.subheadline).foregroundStyle(.black)
                    Text(song.releaseDate ?? "no date").font(.footnote).foregroundStyle(.gray)
                        
                }.padding(10)
                
                Spacer()
                
                AsyncImage(url: URL(string: song.artworkUrl100 ?? "cat")) { image in
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 145, height: 145)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                } placeholder: {
                    ProgressView()
                }
            }
           
            
        }.listStyle(.plain).foregroundStyle(Color(uiColor: .purple))
    }
}

#Preview {
    ChartViewList(songsResult: testResult, textSearch: "")
}
