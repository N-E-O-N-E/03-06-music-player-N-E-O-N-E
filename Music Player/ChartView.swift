//
//  ChartView.swift
//  Music Player
//
//  Created by Markus Wirtz on 30.09.24.

import SwiftUI
import SwiftData

struct ChartView: View {
    
    @State private var songsResult: [Result] = []
    @State private var pickLanguage: Languages = .Germany
    
    var body: some View {
        let textFrameWidth = 270.0
        VStack {
            
            Image("cat")
                .resizable()
                .scaledToFit()
                .opacity(0.9)
                .padding(0)
            
            HStack(alignment:.center) {
                Picker("Language:", selection: $pickLanguage) {
                    ForEach(Languages.allCases) { lang in
                        Text(lang.rawValue).tag(lang)
                            .onChange(of: pickLanguage) {
                                Task {
                                    do {
                                        try await self.DataAndJsonDecoder()
                                    } catch {
                                        print("Data can not load \(error)")
                                    }
                                }
                            }
                    }
                    
                }.pickerStyle(.segmented)
                    .background(Color(hue: 0.9, saturation: 0.6, brightness: 0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal, 10)
                
                
                
            }
            
            VStack {
                List(songsResult, id:\.id) { song in
                    NavigationLink(destination: ChartView()) {
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
                                
                                
                                Text(song.artistName ?? "no artist")
                                    .frame(width: textFrameWidth, alignment: .leading)
                                    .font(.title3)
                                    .foregroundStyle(.black)
                                    .bold()
                                
                                
                                Text(song.name ?? "no name")
                                    .frame(width: textFrameWidth, alignment: .leading)
                                    .font(.callout)
                                    .foregroundStyle(.black)
                                
                            }.padding(10)
                        }
                        .padding(2)
                    }
                }
            }
            .listStyle(.plain)
            Spacer()
        }
        .onAppear() {
            Task {
                do {
                    try await self.DataAndJsonDecoder()
                } catch {
                    print("Data can not load \(error)")
                }
            }
        }
    }
    
    
    private func DataAndJsonDecoder() async throws {
        
        
        guard let path = URL(string: pickLanguage.description) else {
            throw Errors.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: path)
        
        let songs = try JSONDecoder().decode(Response.self, from: data)
        self.songsResult = songs.feed!.results
        
    }
}

#Preview {
    ChartView()
}
