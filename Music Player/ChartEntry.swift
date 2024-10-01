
import Foundation
import SwiftUI

struct Response: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let copyright, country: String
    let icon: String
    let updated: String
    let results: [Result]

}

struct Author: Codable {
    let name: String
    let url: String

}

struct Link: Codable {
    var self1: String
    
    enum CodingKeys: String, CodingKey {
        case self1 = "self"
    }

}

struct Result: Codable {
    let artistName, id, name: String
    let releaseDate: String?
    let artistId: String
    let artistUrl: String
    let contentAdvisoryRating: String?
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
    
}

struct Genre: Codable {
    let genreId, name: String
    let url: String

}
