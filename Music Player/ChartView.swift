//
//  ChartView.swift
//  Music Player
//
//  Created by Markus Wirtz on 30.09.24.

import SwiftUI
import SwiftData

struct ChartView: View {
    
    @State private var songsResult: [Result] = []
    
    var body: some View {
        
        let textFrameWidth = 270.0
        
        Image("cat")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
            .opacity(0.9)
            
        
        VStack {
            List {
            ForEach(songsResult, id: \.id) { song in
                NavigationLink(destination: ChartView()) {
                    HStack{
                        
                        AsyncImage(url: URL(string: song.artworkUrl100)) { image in
                            image
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(.rect(cornerRadius: 8))
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        VStack(alignment: .leading) {
                            
                            
                            Text(song.artistName)
                                .frame(width: textFrameWidth, alignment: .leading)
                                .font(.title3)
                                .foregroundStyle(.black)
                                .bold()
                            
                            
                            Text(song.name)
                                .frame(width: textFrameWidth, alignment: .leading)
                                .font(.callout)
                                .foregroundStyle(.black)
                            
                        }.padding(10)
                    }
                    .padding(2)
                }
            }
            }.listStyle(.plain)
            Spacer()
        }
        .task {
            DataAndJsonDecoder()
        }
    }

    private func DataAndJsonDecoder() {
        
        guard let path = Bundle.main.path(forResource: "charts", ofType: "json") else {
            print(Errors.invalidURL)
            return
            
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            print("Path found")
            
            let songs = try JSONDecoder().decode(Response.self, from: data)
            print("Data found")
            
            
            self.songsResult = songs.feed.results
            
        } catch {
            print(Errors.invalidData)
            return
        }
        
        
    }
    
}

#Preview {
    ChartView()
}
