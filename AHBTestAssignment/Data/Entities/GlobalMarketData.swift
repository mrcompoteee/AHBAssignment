//
//  GlobalMarketData.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

struct GlobalMarketData: Codable, Equatable {
    let coinsCount: Int
    let activeMarketsCount: Int
    let totalMarketCap: Double
    let totalVolume: Double
    let bitcoinDominance: String
    let ethereumDominance: String
    let marketCapChange: String
    let volumeChange: String
    let averagePriceChange: String
    let volumeATH: Double
    let marketCapATH: Double

    enum CodingKeys: String, CodingKey {
        case coinsCount = "coins_count"
        case activeMarketsCount = "active_markets"
        case totalMarketCap = "total_mcap"
        case totalVolume = "total_volume"
        case bitcoinDominance = "btc_d"
        case ethereumDominance = "eth_d"
        case marketCapChange = "mcap_change"
        case volumeChange = "volume_change"
        case averagePriceChange = "avg_change_percent"
        case volumeATH = "volume_ath"
        case marketCapATH = "mcap_ath"
    }
}
