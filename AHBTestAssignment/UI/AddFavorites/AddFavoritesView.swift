//
//  AddFavoritesView.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import SwiftUI

struct AddFavoritesView: View {
    @ObservedObject private var viewModel: AddFavoritesViewModel

    init(viewModel: AddFavoritesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(viewModel.listItemModels) { model in
                    FavoritesListItem(model: model)
                        .task {
                            if viewModel.listItemModels.last == model {
                                await viewModel.fetchTickers()
                            }
                        }
                        .onTapGesture {
                            viewModel.toggleFavorite(model)
                        }
                }
            }
            .task {
                if viewModel.listItemModels.isEmpty {
                    await viewModel.fetchTickers()
                }
            }
            .navigationTitle("Edit Favorites")

            if viewModel.isLoading {
                ProgressView()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Material.ultraThinMaterial)
                    )
            }
        }
    }
}

#Preview {
    AddFavoritesView(
        viewModel: AddFavoritesViewModel(
            tickersRepository: DependencyContainer.shared.tickersRepository
        )
    )
}
