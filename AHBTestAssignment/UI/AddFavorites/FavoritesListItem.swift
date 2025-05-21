//
//  FavoritesListItem.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import SwiftUI

struct FavoritesListItemModel: Identifiable, Equatable {
    var id: String { coin.id }

    let coin: CoinData
    let isFavorite: Bool
}

struct FavoritesListItem: View {
    let model: FavoritesListItemModel

    var body: some View {
        HStack {

            VStack(alignment: .leading, spacing: 4) {
                Text("\(model.coin.symbol)")
                    .font(.headline)

                Text(model.coin.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "star.fill")
                .foregroundColor(model.isFavorite ? .yellow : .gray)
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}
