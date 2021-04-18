//
//  SearchResults.swift
//  DollarCostAveraging
//
//  Created by Nikhilkumar Balne on 18/04/21.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Decodable {
    let items: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case items = "bestMatches"
    }
}

// MARK: - BestMatch
struct SearchResult: Decodable {
    
    let symbol, name, type, currency: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}
