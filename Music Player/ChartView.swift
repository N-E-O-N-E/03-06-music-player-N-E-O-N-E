//
//  ChartView.swift
//  Music Player
//
//  Created by Markus Wirtz on 30.09.24.

import SwiftUI
import SwiftData

struct ChartView: View {
    
    @State private var songsResult: [Result] = []
    @State private var titleResult: String = ""
    @State private var pickLanguage: Languages = .Germany
    @State private var textSearch: String = ""
    @State private var pickCharts: Charts = .Top10
    
    
    var body: some View {
        
        let textFrameWidth = 260.0
        
        VStack {
            HStack {
                VStack(alignment:.leading) {
                    Text("Charts Top 50").font(.title).bold()
                    Text(titleResult).font(.title3)
                    
                    Picker("Charts", selection: $pickCharts) {
                        ForEach(Charts.allCases) { chart in
                            Text(chart.rawValue).tag(chart)
                                .onChange(of: pickCharts) {
                                    Task {
                                        do {
                                            try await self.DataAndJsonDecoder()
                                        } catch {
                                            print("Data can not load \(error)")
                                        }
                                    }
                                }
                        }
                    }
                }
                Spacer()
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .opacity(0.9)
                    .padding(0)
                    .clipShape(.rect(cornerRadius: 10))
            }.padding(.horizontal, 10)
            
            
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
                    .background(Color(hue: 0.3, saturation: 0.5, brightness: 0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal, 10)
            
            
            TextField("Search", text: $textSearch)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
                
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
        
        // Daten entgegennehmen
        guard let path = URL(string: pickLanguage.description + pickCharts.description) else {
            throw Errors.invalidURL
        }
        
        // Daten auslesen
        let (data, _) = try await URLSession.shared.data(from: path)
        
        // Daten umwandeln (decodieren)
        let songs = try JSONDecoder().decode(Response.self, from: data)
        
        self.songsResult = songs.feed!.results
        self.titleResult = songs.feed!.title
        
    }
}

#Preview {
    ChartView()
}
