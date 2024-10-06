//
//  SearchViewList.swift
//  Music Player
//
//  Created by Markus Wirtz on 05.10.24.
//

import SwiftUI

struct SearchViewList: View {
    
    var searchResult: [SearchResult] = []
    
    var body: some View {
        
        List(searchResult, id:\.artistId) { song in
            
            HStack(alignment:.center) {
                VStack(alignment: .leading) {
                    Text(song.trackName).font(.title2).bold()
                    Text(song.artistName).font(.subheadline).foregroundStyle(.black)
                    Text("")
                    Text(song.releaseDate ?? "date not found").font(.footnote).foregroundStyle(.gray)
                    Text(song.collectionExplicitness.rawValue).font(.footnote).foregroundStyle(.orange)
                    Text("Genre: \(song.primaryGenreName)").font(.footnote).foregroundStyle(.black)
                    Text("")
                    
                    Button("Link") {
                        
                    }
                    
                }.padding(10)
                
                Spacer()
                
                AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 130, height: 130)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .opacity(0.4)
                            .rotationEffect(Angle(degrees: 10.0))
                        Rectangle()
                            .frame(width: 130, height: 130)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .rotationEffect(Angle(degrees: 20.0))
                            .opacity(0.4)
                        
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 10)
                        
                    }.padding(.vertical, 15)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            
        }.listStyle(.plain).foregroundStyle(Color(uiColor: .purple))
        
    }
}

#Preview {
    SearchViewList()
}
