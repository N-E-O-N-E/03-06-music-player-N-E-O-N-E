//
//  SearchEntry.swift
//  Music Player
//
//  Created by Markus Wirtz on 02.10.24.
//

import Foundation

struct SearchResponse: Codable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Codable {
    
    let artistId: Int
    let trackId: Int
    let artistName: String
    let trackName: String
    let trackViewUrl: String
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let country: Country
    let primaryGenreName: String
    let contentAdvisoryRating: ContentAdvisoryRating?
    
    enum CodingKeys: String, CodingKey {
        
        case artistId = "artistId"
        case trackId = "trackId"
        case artistName = "artistName"
        case trackName = "trackName"
        case trackViewUrl = "trackViewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case releaseDate = "releaseDate"
        case country = "country"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explicit = "Explicit"
    case clean = "Clean"
}

enum Country: String, Codable {
    case usa = "USA"
    case deu = "DEU"
}

