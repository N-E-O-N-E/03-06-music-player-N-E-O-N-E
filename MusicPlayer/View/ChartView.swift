//
//  ChartView.swift
//  Music Player
//
//  Created by Markus Wirtz on 30.09.24.

import SwiftUI
import SwiftData

struct ChartView: View {
    @State private var titleResult: String = ""
    @State private var pickLanguage: Languages = .Germany
    @State private var pickCharts: Charts = .Top10
    @State private var songsResult: [Result] = []
    @State private var textSearch: String = ""
    @State private var textFrameWidth = 260.0
    
    var body: some View {
        
        VStack {
            Image("cat")
                .resizable()
                .ignoresSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .offset(x: 0, y: 60)
                .frame(height: 90)
                .opacity(0.9)
            
            ZStack {
     
            HStack {
                VStack(alignment:.leading) {
                    Text("Charts Top 50").font(.title).bold().foregroundStyle(.white).shadow(color: .purple, radius: 10)
                    Text(titleResult).font(.title3).foregroundStyle(.white)
                        .shadow(color: .purple, radius: 10)
                        .padding(0)
                }
                Spacer()
            }
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
                .frame(height: 40)
                .background(Color(hue: 0.8, saturation: 0.6, brightness: 0.9))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .shadow(color: .purple, radius: 10)
                .padding(.horizontal, 10)
            
            HStack {
                Text("QuickSearch:").padding(10).font(.callout).foregroundStyle(.white).shadow(color: .purple, radius: 10)
                TextField("Search", text: $textSearch)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                Picker("Charts", selection: $pickCharts) {
                    ForEach(Charts.allCases) { chart in
                        Text(chart.rawValue)
                            .foregroundStyle(.white)
                            .tag(chart)
                            .onChange(of: pickCharts) {
                                Task {
                                    do {
                                        try await DataAndJsonDecoder()
                                    } catch {
                                        print("Data can not load \(error)")
                                    }
                                }
                            }
                    }
                }.pickerStyle(.automatic).padding(0)
                    .frame(width: 100, height: 34).background(.white)
                    .clipShape(.rect(cornerRadius: 5))
                    .padding(.horizontal, 10)
            }
            
            ChartViewList(songsResult: songsResult, textSearch: textSearch)
            
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
    
    func DataAndJsonDecoder() async throws {
        
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
