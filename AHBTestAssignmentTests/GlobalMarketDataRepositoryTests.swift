//
//  GlobalMarketDataRepositoryTests.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 21.05.2025.
//

import XCTest
@testable import AHBTestAssignment

final class GlobalMarketDataRepositoryTests: XCTestCase {
    private var mockAPIProvider: MockAPIProvider!
    private var repository: GlobalMarketDataRepository!

    override func setUp() {
        super.setUp()
        mockAPIProvider = MockAPIProvider()
        repository = GlobalMarketDataRepository(apiProvider: mockAPIProvider)
    }

    override func tearDown() {
        mockAPIProvider = nil
        repository = nil
        super.tearDown()
    }

    func testFetchGlobalMarketDataSuccess() async throws {
        let mockData = GlobalMarketData(
            coinsCount: 14445,
            activeMarketsCount: 37995,
            totalMarketCap: 3437025102123.0845,
            totalVolume: 163370754406.86725,
            bitcoinDominance: "61.44",
            ethereumDominance: "8.86",
            marketCapChange: "0.59",
            volumeChange: "-0.84",
            averagePriceChange: "0.20",
            volumeATH: 344187126292428700,
            marketCapATH: 33242498693028.46
        )

        mockAPIProvider.result = .success([mockData])

        let result = try await repository.fetchGlobalMarketData()

        XCTAssertEqual(result, mockData)
    }

    func testFetchGlobalMarketDataEmptyResponse() async {
        mockAPIProvider.result = .success([])

        do {
            _ = try await repository.fetchGlobalMarketData()
            XCTFail("Expected to throw, but did not")
        } catch let error as GlobalMarketDataRepositoryError {
            XCTAssertEqual(error, .noData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchGlobalMarketDataError() async {
        let error = NSError(domain: "FakeError", code: 1001)
        mockAPIProvider.result = .failure(error)

        do {
            _ = try await repository.fetchGlobalMarketData()
            XCTFail("Expected to throw, but did not")
        } catch let error as NSError {
            XCTAssertEqual(error, error)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
