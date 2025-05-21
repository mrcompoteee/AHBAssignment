//
//  AllTickersRequest.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation

struct AllTickersRequest: APIRequest {
    let start: Int?
    let limit: Int?

    init(start: Int? = nil, limit: Int? = nil) {
        self.start = start
        self.limit = limit
    }

    var path: String { "/api/tickers/" }

    var queryItems: [URLQueryItem]? {
        guard let start, let limit else { return nil }

        return [
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "limit", value: String(limit))
        ]
    }
}
