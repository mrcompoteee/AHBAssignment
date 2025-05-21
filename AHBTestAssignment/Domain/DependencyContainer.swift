//
//  DependencyContainer.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

final class DependencyContainer {
    static let shared = DependencyContainer()

    private(set) var tickersRepository: TickersRepository
    private(set) var globalMarketDataRepository: GlobalMarketDataRepository

    private init() {
        self.tickersRepository = TickersRepository()
        self.globalMarketDataRepository = GlobalMarketDataRepository()
    }
}
