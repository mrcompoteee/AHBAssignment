//
//  HomeViewModel.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import Foundation
import SwiftUI

@MainActor final class HomeViewModel: ObservableObject {
    // MARK: Dependencies
    private let globalMarketDataRepository: GlobalMarketDataRepository
    private let tickersRepository: TickersRepository

    // MARK: Published
    @Published private(set) var lastUpdateString: String?
    @Published private(set) var isLoading = false
    @Published private(set) var globalMarketData: GlobalMarketData?
    @Published private(set) var favorites = [CoinData]()

    // MARK: Constants
    private let pollingInterval: UInt64 = 3

    // MARK: Properties
    private lazy var dateFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated

        return formatter
    }()

    private var pollingTask: Task<Void, Never>? = nil

    // MARK: Lifecycle
    init(globalMarketDataRepository: GlobalMarketDataRepository, tickersRepository: TickersRepository) {
        self.globalMarketDataRepository = globalMarketDataRepository
        self.tickersRepository = tickersRepository
    }

    deinit {
        pollingTask?.cancel()
    }

    // MARK: Polling
    func startPolling() {
        pollingTask?.cancel()
        pollingTask = Task {
            while !Task.isCancelled {
                await fetchFavorites()
                await fetchGlobalMarketData()

                try? await Task.sleep(nanoseconds: pollingInterval * NSEC_PER_SEC)
            }
        }
    }
}

// MARK: Fetch
private extension HomeViewModel {
    func fetchFavorites() async {
        isLoading = true

        do {
            let (coins, date) = try await tickersRepository.fetchFavoriteCoinsData()
            favorites = coins.sorted { $0.rank < $1.rank }

            if date.timeIntervalSinceNow < -TimeInterval(pollingInterval) {
                lastUpdateString = self.dateFormatter.localizedString(for: date, relativeTo: .now)
            } else {
                lastUpdateString = nil
            }
        } catch {
            favorites = []
        }

        isLoading = false
    }

    func fetchGlobalMarketData() async {
        do {
            globalMarketData = try await globalMarketDataRepository.fetchGlobalMarketData()
        } catch {
            globalMarketData = nil
        }
    }
}
