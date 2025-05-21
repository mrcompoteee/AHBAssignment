//
//  StandardUserDefaultsProvider.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 21.05.2025.
//

import Foundation

class StandardUserDefaultsProvider: UserDefaultsProvider {
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(userDefaults: UserDefaults = .standard, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }

    func set<T: Encodable>(_ value: T, forKey key: String) {
        let data = try? encoder.encode(value)
        userDefaults.set(data, forKey: key)
    }

    func value<T: Decodable>(forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
}
