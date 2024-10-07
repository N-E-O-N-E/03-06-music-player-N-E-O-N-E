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
            NavigationLink(destination: SearchViewListDetail(selectedSong: song)) {
                
            HStack(alignment:.center) {
                VStack(alignment: .leading) {
                    
                    Text(song.trackName).font(.title3).bold()
                    Text(song.artistName).font(.subheadline).foregroundStyle(.black)
                    Text(song.releaseDate ?? "date not found").font(.footnote).foregroundStyle(.gray)
                    Text("Genre: \(song.primaryGenreName)").font(.footnote).foregroundStyle(.black)
                    
                }.padding(10)
                
                Spacer()
                
                AsyncImage(url: URL(string: song.artworkUrl100 ?? "cat")) { image in
                    
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
        }
        }.listStyle(.plain).foregroundStyle(Color(uiColor: .purple))
            .progressViewStyle(.linear)
        
    }
}
