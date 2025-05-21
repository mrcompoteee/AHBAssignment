//
//  Untitled.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import Foundation

class GlobalMarketDataRepository {
    private let apiProvider: APIProvider

    init(apiProvider: APIProvider = StandardAPIProvider()) {
        self.apiProvider = apiProvider
    }

    // MARK: - CoinLore API
    func fetchGlobalMarketData() async throws -> GlobalMarketData {
        let request = GlobalMarketDataRequest()
        let data: [GlobalMarketData] = try await apiProvider.executeRequest(request)

        if let data = data.first {
            return data
        } else {
            throw GlobalMarketDataRepositoryError.noData
        }
    }
}

enum GlobalMarketDataRepositoryError: Error {
    case noData
}
