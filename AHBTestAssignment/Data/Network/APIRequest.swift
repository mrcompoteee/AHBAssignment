//
//  APIRequest.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APIRequest {
    var scheme: String { get }

    var host: String { get }

    var path: String { get }

    var method: HTTPMethod { get }

    var headers: [String: String]? { get }

    var queryItems: [URLQueryItem]? { get }
}

extension APIRequest {
    var scheme: String { "https" }
    
    var host: String { "api.coinlore.net" }

    var method: HTTPMethod { .get }

    var headers: [String: String]? { nil }
}
