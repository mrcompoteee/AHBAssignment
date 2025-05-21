//
//  APIProvider.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation

protocol APIProvider {
    func executeRequest<T: Decodable>(_ request: APIRequest) async throws -> T
}
