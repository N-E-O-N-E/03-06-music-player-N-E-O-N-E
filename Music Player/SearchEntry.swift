//
//  SearchEntry.swift
//  Music Player
//
//  Created by Markus Wirtz on 02.10.24.
//

import Foundation

struct SearchResponse: Codable {
    let resultCount: Int?
    let results: [SearchResult]?
}

struct SearchResult: Codable {
    let wrapperType, kind: String?
    let artistID, collectionID, trackID: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: Date?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistID: Int?
    let collectionArtistName: String?
    let collectionArtistViewURL: String?

//    enum CodingKeys: String, CodingKey {
//        case wrapperType, kind
//        case artistID = "artistId"
//        case collectionID = "collectionId"
//        case trackID = "trackId"
//        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
//        case artistViewURL = "artistViewUrl"
//        case collectionViewURL = "collectionViewUrl"
//        case trackViewURL = "trackViewUrl"
//        case previewURL = "previewUrl"
//        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness,
//             trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
//        case collectionArtistID = "collectionArtistId"
//        case collectionArtistName
//        case collectionArtistViewURL = "collectionArtistViewUrl"
//    }
}
