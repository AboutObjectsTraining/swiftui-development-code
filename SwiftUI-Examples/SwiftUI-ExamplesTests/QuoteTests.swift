// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest
import Combine

let url = URL(string: "https://api.coinbase.com/v2/prices/spot")!

class QuoteTests: XCTestCase {
    
    var quote: BitcoinQuote?
    let decoder = JSONDecoder()

    // Compare this Combine-based implementation to the
    // async/await version further below.
    func testFetchQuotesWithCombine() {
        let expectation = XCTestExpectation()
        var subscriptions = Set<AnyCancellable>()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in data }
            .decode(type: BitcoinQuote.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] quote in
                self?.quote = quote
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2)
        
        print(quote?.formattedAmount ?? "")
        XCTAssertNotNil(quote)
    }
    
    // Async-await version of the Combine-based unit test.
    @MainActor func testFetchQuotesWithAsyncAwait() async throws {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        quote = try decoder.decode(BitcoinQuote.self, from: data)
        
        print(quote?.formattedAmount ?? "nil")
        XCTAssertNotNil(quote)
    }
}

struct BitcoinQuote: Decodable {
    enum CodingKeys: CodingKey {
        case data
    }
    
    let amount: Double
    let base: String
    let currency: String
    
    
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: amount)) ?? "--"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let values = try container.decode(Dictionary<String, String>.self, forKey: .data)
        amount = Double(values["amount"] ?? "") ?? 0
        base = values["base"] ?? ""
        currency = values["currency"] ?? ""
    }
}
