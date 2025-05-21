//
//  TickersRepository.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation

class TickersRepository {
    private let apiProvider: any APIProvider
    private let userDefaultsProvider: any UserDefaultsProvider

    init(apiProvider: APIProvider = StandardAPIProvider(), userDefaultsProvider: UserDefaultsProvider = StandardUserDefaultsProvider()) {
        self.apiProvider = apiProvider
        self.userDefaultsProvider = userDefaultsProvider
    }

    // MARK: - CoinLore API
    func fetchAllCoinsData(start: Int, limit: Int) async throws -> [CoinData] {
        let request = AllTickersRequest(start: start, limit: limit)
        let response: Tickers = try await apiProvider.executeRequest(request)

        return response.coins
    }

    func fetchFavoriteCoinsData() async throws -> ([CoinData], Date) {
        guard let identifiers: Set<String> = userDefaultsProvider.value(forKey: Self.favoriteIdsKey) else {
            return ([], .now)
        }

        let request = TickerDetailsRequest(identifiers: Array(identifiers))

        do {
            let response: [CoinData] = try await apiProvider.executeRequest(request)
            let lastFetchDate = Date.now
            self.userDefaultsProvider.set(response, forKey: Self.favoritesKey)
            self.userDefaultsProvider.set(lastFetchDate, forKey: Self.lastFavoritesFetchKey)

            return (response, lastFetchDate)
        } catch {
            if let cachedFavorited: [CoinData] = self.userDefaultsProvider.value(forKey: Self.favoritesKey),
               let lastFetchDate: Date = self.userDefaultsProvider.value(forKey: Self.lastFavoritesFetchKey) {
                return (cachedFavorited, lastFetchDate)
            } else {
                throw error
            }
        }
    }

    // MARK: - Add/remove favorite
    func isFavorite(id: String) -> Bool {
        guard let favorites: Set<String> = userDefaultsProvider.value(forKey: Self.favoriteIdsKey),
              favorites.contains(id) else {
            return false
        }

        return true
    }

    func toggleFavorite(id: String) {
        guard let favorites: Set<String> = userDefaultsProvider.value(forKey: Self.favoriteIdsKey),
              favorites.contains(id) else {
            addFavorite(id: id)
            return
        }

        removeFavorite(id: id)
    }

    private func addFavorite(id: String) {
        var favorites: Set<String> = userDefaultsProvider.value(forKey: Self.favoriteIdsKey) ?? []

        guard !favorites.contains(id) else {
            return
        }

        favorites.insert(id)
        userDefaultsProvider.set(favorites, forKey: Self.favoriteIdsKey)
    }

    private func removeFavorite(id: String) {
        guard var favorites: Set<String> = userDefaultsProvider.value(forKey: Self.favoriteIdsKey) else {
            return
        }

        favorites.remove(id)
        userDefaultsProvider.set(favorites, forKey: Self.favoriteIdsKey)
    }
}

private extension TickersRepository {
    static let lastFavoritesFetchKey = "lastFavoritesFetch"
    static let favoriteIdsKey = "favoriteIds"
    static let favoritesKey = "favorites"
}
