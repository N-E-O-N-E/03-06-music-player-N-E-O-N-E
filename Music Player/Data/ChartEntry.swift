
import Foundation
import SwiftUI

struct Response: Codable {
    let feed: Feed?
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

struct Result: Codable, Identifiable {
    let id: String
    let artistName, name: String?
    let releaseDate: String?
    let artistId: String
    let artistUrl: String?
    let contentAdvisoryRating: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?
    
}

struct Genre: Codable {
    var genreId: String?
    let name: String?
    let url: String?

}


let testResult: [Result] = [.init(id: "01", artistName: "ABC", name: "ABC", releaseDate: "ABC", artistId: "", artistUrl: "", contentAdvisoryRating: "", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/69/21/cf/6921cff3-7074-118a-ece2-4012450e6c75/093624839811.jpg/100x100bb.jpg", genres: [.init(genreId: "", name: "", url: "")], url: "")]
