//
//  MockAPIProvider.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 21.05.2025.
//

@testable import AHBTestAssignment

final class MockAPIProvider: APIProvider {
    var result: Result<Any, Error>?

    func executeRequest<T: Decodable>(_ request: APIRequest) async throws -> T {
        if let result = result {
            switch result {
            case .success(let data):
                if let data = data as? T {
                    return data
                } else {
                    throw GlobalMarketDataRepositoryError.noData
                }
            case .failure(let error):
                throw error
            }
        }

        throw GlobalMarketDataRepositoryError.noData
    }
}
