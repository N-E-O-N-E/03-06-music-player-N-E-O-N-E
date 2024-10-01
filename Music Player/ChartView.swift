//
//  ChartView.swift
//  Music Player
//
//  Created by Markus Wirtz on 30.09.24.

import SwiftUI
import SwiftData

struct ChartView: View {
    
    @State private var songsResult: [Result] = []
    @State private var pickLanguage: Languages = .Deutschland
    
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
                            DataAndJsonDecoder()
                        }
                }
                
            }.pickerStyle(.segmented)
                .background(Color(hue: 0.9, saturation: 0.6, brightness: 0.9))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal, 10)
            
            
            
        }
        
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
            }
            .listStyle(.plain)
            Spacer()
        }
        .task {
            DataAndJsonDecoder()
        }
        }.frame(width: 390)
}

    private func DataAndJsonDecoder() {
        
        
        guard let path = URL(string: pickLanguage.description) else {
            print(Errors.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: path) { data, _, error in
            
            if let error = error {
                print(Errors.invalidURL, error)
                return
            }
            
            guard let data = data else {
                print(Errors.invalidData)
                return
            }
            
            do {
                
                let songs = try JSONDecoder().decode(Response.self, from: data)
                print("Data found")
                
                self.songsResult = songs.feed.results
                
                
            } catch {
                print(Errors.invalidData)
                return
            }
        }.resume()
        
    }
    
}

#Preview {
    ChartView()
}
