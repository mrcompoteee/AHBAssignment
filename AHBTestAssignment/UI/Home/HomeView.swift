//
//  HomeView.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

import SwiftUI

enum Route: Hashable {
    case addFavorites
}

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                favoritesList()
                lastUpdateText()
                globalMarketDataView()
            }
            .navigationTitle("Favorite Coins")
            .toolbar {
                NavigationLink(value: Route.addFavorites) {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .addFavorites:
                    AddFavoritesView(
                        viewModel: AddFavoritesViewModel(
                            tickersRepository: DependencyContainer.shared.tickersRepository
                        )
                    )
                }
            }
        }
    }

    @ViewBuilder private func favoritesList() -> some View {
        List(viewModel.favorites) { coin in
            HomeListItem(coin: coin)
        }
        .animation(.default, value: viewModel.favorites)
        .onAppear {
            viewModel.startPolling()
        }
    }

    @ViewBuilder private func globalMarketDataView() -> some View {
        if let data = viewModel.globalMarketData {
            GlobalMarketDataView(data: data)
                .animation(.default, value: viewModel.globalMarketData)
        }
    }

    @ViewBuilder private func lastUpdateText() -> some View {
        if let lastUpdateString = viewModel.lastUpdateString {
            HStack {
                Text("Updated \(lastUpdateString)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            globalMarketDataRepository: DependencyContainer.shared.globalMarketDataRepository,
            tickersRepository: DependencyContainer.shared.tickersRepository
        )
    )
}
