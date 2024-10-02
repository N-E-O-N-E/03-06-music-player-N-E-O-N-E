//
//  Enum.swift
//  Music Player
//
//  Created by Markus Wirtz on 01.10.24.
//

import Foundation


enum Errors: Error {
    case invalidURL
    case invalidData
    
    var description: String {
        switch self {
            
        case .invalidURL: return "Invalid URL"
        case .invalidData: return "Invalid Data"
            
        }
    }
}


enum Languages: String, CustomStringConvertible, CaseIterable, Identifiable {
    
    case Germany
    case USA
    case Japan
    case UK
    case France
    
    var id: String {
        self.rawValue
    }
    
    var description: String {
        switch self {
            
        case .Germany: return "https://rss.applemarketingtools.com/api/v2/de/music/most-played/50/songs.json"
        case .USA: return "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/songs.json"
        case .Japan: return "https://rss.applemarketingtools.com/api/v2/jp/music/most-played/50/songs.json"
        case .UK: return "https://rss.applemarketingtools.com/api/v2/gb/music/most-played/50/songs.json"
        case .France: return "https://rss.applemarketingtools.com/api/v2/fr/music/most-played/50/songs.json"
            
        }
    }
}




