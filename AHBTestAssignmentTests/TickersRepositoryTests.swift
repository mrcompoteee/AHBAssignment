//
//  TickersRepositoryTests.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 21.05.2025.
//

import XCTest
@testable import AHBTestAssignment

final class TickersRepositoryTests: XCTestCase {
    private var mockAPIProvider: MockAPIProvider!
    private var userDefaultsProvider: MockUserDefaultsProvider!
    private var repository: TickersRepository!

    override func setUp() {
        super.setUp()
        mockAPIProvider = MockAPIProvider()
        userDefaultsProvider = MockUserDefaultsProvider()
        repository = TickersRepository(apiProvider: mockAPIProvider, userDefaultsProvider: userDefaultsProvider)
    }

    func testFetchAllCoinsDataSuccess() async throws {
        let expectedCoins = [
            CoinData(
                id: "90",
                symbol: "BTC",
                name: "Bitcoin",
                rank: 1,
                priceUSD: "106289.75",
                percentChange24hours: "1.12",
                percentChange1hour: "0.14",
                percentChange7days: "2.04",
                priceBTC: "1.00",
                marketCapUSD: "2111613445230.60",
                volume24hoursUSD: 35589225802.54721,
                volume24hours: 35480991841.17727,
                circulatingSupply: "19866577.00",
                totalSupply: "19866577",
                maximumSupply: "21000000"
            )
        ]
        mockAPIProvider.result = .success(Tickers(coins: expectedCoins))

        let result = try await repository.fetchAllCoinsData(start: 0, limit: 10)

        XCTAssertEqual(result, expectedCoins)
    }

    func testFetchFavoriteCoinsDataSuccess() async throws {
        let expectedCoins = [btcCoinData, ethCoinData]
        let ids = Set([btcCoinData.id, ethCoinData.id])
        userDefaultsProvider.set(ids, forKey: "favoriteIds")
        mockAPIProvider.result = .success(expectedCoins)

        let (coins, date) = try await repository.fetchFavoriteCoinsData()

        XCTAssertEqual(coins, expectedCoins)
        XCTAssertEqual(userDefaultsProvider.value(forKey: "favorites") as [CoinData]?, expectedCoins)
        XCTAssertEqual(userDefaultsProvider.value(forKey: "lastFavoritesFetch") as Date?, date)
    }

    func testFetchFavoriteCoinsDataFallbackToCache() async throws {
        let cachedCoins = [btcCoinData]
        let cachedDate = Date.distantPast

        userDefaultsProvider.set(Set([btcCoinData.id]), forKey: "favoriteIds")
        userDefaultsProvider.set(cachedCoins, forKey: "favorites")
        userDefaultsProvider.set(cachedDate, forKey: "lastFavoritesFetch")

        mockAPIProvider.result = .failure(NSError(domain: "FakeError", code: 1001))

        let (coins, date) = try await repository.fetchFavoriteCoinsData()

        XCTAssertEqual(coins, cachedCoins)
        XCTAssertEqual(date, cachedDate)
    }

    func testFavorite() {
        userDefaultsProvider.set(Set([btcCoinData.id]), forKey: "favoriteIds")
        XCTAssertTrue(repository.isFavorite(id: btcCoinData.id))
    }

    func testNotFavorite() {
        userDefaultsProvider.set(Set([ethCoinData.id]), forKey: "favoriteIds")
        XCTAssertFalse(repository.isFavorite(id: btcCoinData.id))
    }

    // MARK: - toggleFavorite

    func testToggleFavoriteAddsWhenMissing() {
        repository.toggleFavorite(id: btcCoinData.id)
        let result: Set<String> = userDefaultsProvider.value(forKey: "favoriteIds")!
        XCTAssertTrue(result.contains(btcCoinData.id))
    }

    func testToggleFavoriteRemovesWhenPresent() {
        userDefaultsProvider.set(Set([btcCoinData.id]), forKey: "favoriteIds")
        repository.toggleFavorite(id: btcCoinData.id)
        let result: Set<String> = userDefaultsProvider.value(forKey: "favoriteIds")!
        XCTAssertFalse(result.contains(btcCoinData.id))
    }
}

private extension TickersRepositoryTests {
    var btcCoinData: CoinData {
        CoinData(
            id: "90",
            symbol: "BTC",
            name: "Bitcoin",
            rank: 1,
            priceUSD: "106289.75",
            percentChange24hours: "1.12",
            percentChange1hour: "0.14",
            percentChange7days: "2.04",
            priceBTC: "1.00",
            marketCapUSD: "2111613445230.60",
            volume24hoursUSD: 35589225802.54721,
            volume24hours: 35480991841.17727,
            circulatingSupply: "19866577.00",
            totalSupply: "19866577",
            maximumSupply: "21000000"
        )
    }

    var ethCoinData: CoinData {
        CoinData(
            id: "80",
            symbol: "ETH",
            name: "Ethereum",
            rank: 2,
            priceUSD: "2527.94",
            percentChange24hours: "0.51",
            percentChange1hour: "0.19",
            percentChange7days: "-5.97",
            priceBTC: "0.023783",
            marketCapUSD: "304549027143.35",
            volume24hoursUSD: 18865455782.386494,
            volume24hours: 20334489963.711857,
            circulatingSupply: "120473321.71",
            totalSupply: "122375302",
            maximumSupply: ""
        )
    }
}
