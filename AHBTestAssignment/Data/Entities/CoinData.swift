//
//  CoinData.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

struct CoinData: Codable, Identifiable, Equatable {
    let id: String
    let symbol: String
    let name: String
    let rank: Int
    let priceUSD: String
    let percentChange24hours: String
    let percentChange1hour: String
    let percentChange7days: String
    let priceBTC: String
    let marketCapUSD: String
    let volume24hoursUSD: Double
    let volume24hours: Double
    let circulatingSupply: String?
    let totalSupply: String?
    let maximumSupply: String?

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case rank
        case priceUSD = "price_usd"
        case percentChange24hours = "percent_change_24h"
        case percentChange1hour = "percent_change_1h"
        case percentChange7days = "percent_change_7d"
        case priceBTC = "price_btc"
        case marketCapUSD = "market_cap_usd"
        case volume24hoursUSD = "volume24"
        case volume24hours = "volume24a"
        case circulatingSupply = "csupply"
        case totalSupply = "tsupply"
        case maximumSupply = "msupply"
    }
}

