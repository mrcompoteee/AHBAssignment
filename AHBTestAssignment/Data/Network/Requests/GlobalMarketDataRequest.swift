//
//  GlobalMarketDataRequest.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation

struct GlobalMarketDataRequest: APIRequest {
    var path: String { "/api/global/" }

    var queryItems: [URLQueryItem]?
}
