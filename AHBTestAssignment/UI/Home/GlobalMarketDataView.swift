//
//  GlobalMarketDataView.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import SwiftUI

struct GlobalMarketDataView: View {
    let data: GlobalMarketData

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                primaryLabelContainer(title: "Market Cap", value: "$\(String(data.totalMarketCap).abbreviatedNumber())")

                Spacer()

                primaryLabelContainer(title: "24h Volume", value: "$\(String(data.totalVolume).abbreviatedNumber())")

                Spacer()

                primaryLabelContainer(title: "BTC Dominance", value: "\(data.bitcoinDominance)%")
            }

            HStack(spacing: 16) {
                secondaryLabelContainer(text: "Coins: \(data.coinsCount)")
                secondaryLabelContainer(text: "Markets: \(data.activeMarketsCount)")
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(Color(.systemBackground).opacity(0.95))
    }

    @ViewBuilder private func primaryLabelContainer(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
        }
    }

    @ViewBuilder private func secondaryLabelContainer(text: String) -> some View {
        Text(text)
            .font(.caption2)
            .foregroundColor(.secondary)
    }
}
