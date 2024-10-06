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
    @State private var tabID: String = ""
    
    var body: some View {
        
        List(songsResult.filter { song in
            textSearch.isEmpty || song.name!.lowercased().contains(textSearch.lowercased()) ||
            song.artistName!.lowercased().contains(textSearch.lowercased())}, id:\.id) { song in
                
                NavigationLink {
                    ChartDetailView(song: song)
                    
                } label: {
                    
                    HStack(alignment:.center) {
                        
                        VStack(alignment: .leading) {
                            
                            Text(song.artistName ?? "artist  not found").font(.title3).bold()
                            Text(song.name ?? "title not found").font(.subheadline).foregroundStyle(.black)
                            //Text(song.releaseDate ?? "date  not found").font(.footnote).foregroundStyle(.gray)
                            Text(song.contentAdvisoryRating ?? "").font(.footnote).foregroundStyle(.orange)
                            
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
                                    .frame(width: tabID == song.id ? 160 : 125, height: tabID == song.id ? 160 : 125)
                                    .clipShape(RoundedRectangle(cornerRadius: tabID == song.id ? 20 : 10))
                                    .shadow(radius: tabID == song.id ? 10 : 20)
                                    .animation(.bouncy(duration: 0.5, extraBounce: 0.5), value: tabID)
                                    .onTapGesture {
                                        tabID = song.id
                                    }
                                
                                Text(tabID == song.id ? "Release date:\n\(song.releaseDate ?? "no date")" : "")
                                    .font(.title3).foregroundStyle(.white).shadow(color:.purple, radius: 20)
                                
                            }.padding(.vertical, 15)
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }.listStyle(.plain).foregroundStyle(Color(uiColor: .purple))
    }
}

#Preview {
    ChartViewList(songsResult: testResult, textSearch: "")
}
