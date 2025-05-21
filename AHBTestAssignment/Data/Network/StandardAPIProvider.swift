//
//  APIProvider.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation

enum APIRequestError: Error {
    case invalidURL
}

class StandardAPIProvider: APIProvider {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = URLSession(configuration: .ephemeral), decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func executeRequest<T: Decodable>(_ request: APIRequest) async throws -> T {
        var components = URLComponents()
        components.scheme = request.scheme
        components.host = request.host
        components.path = request.path
        components.queryItems = request.queryItems

        guard let url = components.url else {
            throw APIRequestError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        let data = try await session.data(for: urlRequest)

        return try decoder.decode(T.self, from: data.0)
    }
}
