//
//  SearchViewListDetail.swift
//  Music Player
//
//  Created by Markus Wirtz on 06.10.24.
//

import SwiftUI

struct SearchViewListDetail: View {
    var selectedSong: SearchResult
    
    var body: some View {
        
        VStack(alignment:.center) {
            
            AsyncImage(url: URL(string: selectedSong.artworkUrl100 ?? "cat")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(20)
                
            } placeholder: {
                ProgressView()
            }
            
            HStack {
                Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
                    
                    GridRow {
                        Text("Song:")
                        Text(selectedSong.trackName).font(.title2).bold()
                    }
                    GridRow {
                        Text("Artist:")
                        Text(selectedSong.artistName).bold()
                    }
                    GridRow {
                        Text("Release:")
                        Text(selectedSong.releaseDate ?? "unknown")
                    }
                    GridRow {
                        Text("Genre:")
                        Text(selectedSong.primaryGenreName)
                    }
                }
                .padding(20)
                Spacer()
            }
            Spacer()
            Button {
                // Code MusikPreview Play mit iTuneAPI
                
            } label: {
                Text("Track Preview")
                    .frame(width: 300, height: 40)
                    .background(.purple)
                    .foregroundColor(.white)
                    .clipShape(.capsule)
                    .shadow(radius: 4)
            }.padding()
            
//            Link(destination: URL(string: selectedSong.trackViewUrl ?? "") {
//                Image("applemusicBadge")
//                    .resizable()
//                    .frame(width: 150, height: 50)
//                    .scaledToFill()
//            }
            
            // Link wird nicht genutzt da es projektspezifische Probleme gibt.
            // Lösung abgesprochen mit Martin Hegel im Call 07.10.24  14:17 bei Rückfragen
            // Lösungen probiert: Projekt Build reset, Target neu, Setting überprüft etc... ohne Erfolg.
            
            Button(action: {
                if let url = URL(string: selectedSong.trackViewUrl ?? "") {
                    UIApplication.shared.open(url)
                }
            }) {
                Image("applemusicBadge")
                    .resizable()
                    .frame(width: 150, height: 50)
                    .scaledToFill()
            }
            
        }.padding(30)
            .navigationBarTitle("Song information")
            .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

#Preview {
    let testSong: SearchResult = .init(artistId: 01, trackId: 01, artistName: "ArtistName", trackName: "TrackName", trackViewUrl: "URL", artworkUrl30: "cat", artworkUrl60: "cat", artworkUrl100: "cat", releaseDate: "ReleaseDate", country: .deu, primaryGenreName: "Genre", contentAdvisoryRating: .explicit)
    SearchViewListDetail(selectedSong: testSong)
}
