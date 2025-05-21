//
//  AHBTestAssignmentApp.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import SwiftUI

@main
struct AHBTestAssignmentApp: App {
    @StateObject private var viewModel: HomeViewModel = {
        HomeViewModel(
            globalMarketDataRepository: DependencyContainer.shared.globalMarketDataRepository,
            tickersRepository: DependencyContainer.shared.tickersRepository
        )
    }()

    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: viewModel
            )
        }
    }
}
