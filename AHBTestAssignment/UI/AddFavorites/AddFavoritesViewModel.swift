//
//  AddFavoritesViewModel.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import Foundation
import SwiftUI

@MainActor final class AddFavoritesViewModel: ObservableObject {
    // MARK: Dependencies
    private let tickersRepository: TickersRepository

    // MARK: Published
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var listItemModels = [FavoritesListItemModel]()

    // MARK: Properties
    private var start = 0
    private let limit = 100
    private var canLoadMore = true
    private var coins = [CoinData]()

    // MARK: Lifecycle
    init(tickersRepository: TickersRepository) {
        self.tickersRepository = tickersRepository
    }

    func fetchTickers() async {
        guard !isLoading, canLoadMore else { return }

        isLoading = true

        do {
            let response = try await tickersRepository.fetchAllCoinsData(start: start, limit: limit)

            coins += response
            start += limit
            canLoadMore = !response.isEmpty
            updateListItemModels()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func toggleFavorite(_ listItem: FavoritesListItemModel) {
        tickersRepository.toggleFavorite(id: listItem.coin.id)
        updateListItemModels()
    }

    private func updateListItemModels() {
        listItemModels = coins.map { FavoritesListItemModel(coin: $0, isFavorite: tickersRepository.isFavorite(id: $0.id)) }
    }
}
