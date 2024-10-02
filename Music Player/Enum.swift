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
            
        case .Germany: return "https://rss.applemarketingtools.com/api/v2/de/music/most-played/"
        case .USA: return "https://rss.applemarketingtools.com/api/v2/us/music/most-played/"
        case .Japan: return "https://rss.applemarketingtools.com/api/v2/jp/music/most-played/"
        case .UK: return "https://rss.applemarketingtools.com/api/v2/gb/music/most-played/"
        case .France: return "https://rss.applemarketingtools.com/api/v2/fr/music/most-played/"
            
        }
    }
}

enum Charts: String, CustomStringConvertible, CaseIterable, Identifiable {
    case Top10
    case Top20
    case Top50
    case Top100
    
    var id: String {
        self.rawValue
    }
    
    var description: String {
        switch self {
            
        case .Top10: return "10/songs.json"
        case .Top20: return "20/songs.json"
        case .Top50: return "50/songs.json"
        case .Top100: return "100/songs.json"
            
        }
    }
    
    
}




