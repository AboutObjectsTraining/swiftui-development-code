// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

struct QuotesWrapper: Codable {
    struct Response: Codable {
        let result: [Quote]
        let error: String?
    }
    
    let quoteResponse: Response
    
    var quotes: [Quote] { return quoteResponse.result }
}

struct Quote: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case symbol
        case name = "longName"
        case price = "regularMarketPrice"
    }
    
    let symbol: String
    let name: String
    let price: Decimal
    
    var id: String { name }
}
