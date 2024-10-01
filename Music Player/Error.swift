//
//  Error.swift
//  Music Player
//
//  Created by Markus Wirtz on 30.09.24.
//

import SwiftUI

enum Errors: CustomStringConvertible {
    case invalidURL
    case invalidData
    
    var description: String {
        switch self {
            
        case .invalidURL: return "Invalid URL"
        case .invalidData: return "Invalid Data"
            
        }
    }
}
