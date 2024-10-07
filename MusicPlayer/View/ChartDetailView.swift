//
//  ChartDetailView.swift
//  Music Player
//
//  Created by Markus Wirtz on 05.10.24.
//

import SwiftUI
import MusicKit

struct ChartDetailView: View {
    
    var song: Result
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: song.artworkUrl100 ?? "cat")) { image in
                
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .frame(width: 230, height: 230)
                        .background(.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .opacity(0.3)
                        .rotationEffect(Angle(degrees: 10.0))
                    Rectangle()
                        .frame(width: 230, height: 230)
                        .background(.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .rotationEffect(Angle(degrees: 20.0))
                        .opacity(0.2)
                    
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 220, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(color:.purple, radius: 20)
                    
                    
                    if song.contentAdvisoryRating != nil {
                        ZStack{
                            Image(systemName: "star.fill" )
                                .foregroundColor(.orange)
                                .scaleEffect(2.0)
                                .padding(20)
                                .shadow(color: .black, radius: 10)
                            Text("ex").foregroundStyle(.white)
                        }
                    }
                    
                }.padding(.vertical, 50)
                
            } placeholder: {
                ProgressView()
            }
            
            VStack {
                Divider()
                
                Grid(alignment: .leading) {  // Align the whole grid to the leading edge
                    GridRow {
                        Text("Artist:").font(.title2).bold()
                        Text(song.artistName ?? "artist not found").font(.title2)
                    }
                    
                    GridRow {
                        Text("Title:").font(.title2).bold()
                        Text(song.name ?? "title not found").font(.title2)
                    }
                    
                    Divider()
                    
                    GridRow {
                        Text("Release:").font(.title2).bold()
                        Text(song.releaseDate ?? "date  not found").font(.title2)
                    }
                    
                    GridRow {
                        Text("Rating:").font(.title2).bold()
                        Text(song.contentAdvisoryRating ?? "rating not found").font(.title2)
                    }
                    Divider()
                    
                    GridRow {
                        Text("Genre:").font(.title2).bold()
                        Text(song.genres?[0].name ?? "no genre found").font(.title2)
                    }
                }
                .padding(.horizontal, 30)
            }
            
            Spacer()
            
            Button {
                
                // Code - Charts - API Song Preview
                
            } label: {
                Text("Track Preview")
                    .frame(width: 300, height: 40)
                    .background(.purple)
                    .foregroundColor(.white)
                    .clipShape(.capsule)
                    .shadow(radius: 4)
            }.padding()
            
            Button(action: {
                if let url = URL(string: song.url) {
                    UIApplication.shared.open(url)
                }
            }) {
                Image("applemusicBadge")
                    .resizable()
                    .frame(width: 150, height: 50)
                    .scaledToFill()
            }
        }
    }
}

#Preview {
    ChartDetailView(song: testResult[0])
}
