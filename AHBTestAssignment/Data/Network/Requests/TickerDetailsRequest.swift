//
//  TickerDetailsRequest.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation

struct TickerDetailsRequest: APIRequest {
    let identifiers: [String]

    var path: String { "/api/ticker/" }

    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "id", value: identifiers.joined(separator: ","))]
    }
}
