//
//  Tickers.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 03.05.2025.
//

struct Tickers: Codable {
    let coins: [CoinData]

    enum CodingKeys: String, CodingKey {
        case coins = "data"
    }
}
