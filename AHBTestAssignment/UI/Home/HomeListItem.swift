//
//  HomeListItem.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import SwiftUI

struct HomeListItem: View {
    let coin: CoinData

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(coin.symbol)")
                    .font(.headline)

                Text(coin.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(coin.priceUSD.abbreviatedNumber())")
                    .font(.headline)

                Text(coin.percentChange24hours)
                    .font(.caption)
                    .foregroundColor(.foregroundColor(forValueDelta: coin.percentChange24hours))
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color(.systemBackground))
    }
}
