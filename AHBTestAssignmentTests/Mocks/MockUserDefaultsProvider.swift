//
//  MockUserDefaultsProvider.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 21.05.2025.
//

@testable import AHBTestAssignment

class MockUserDefaultsProvider: UserDefaultsProvider {
    private var store: [String: Any] = [:]

    func set<T: Encodable>(_ value: T, forKey key: String) {
        store[key] = value
    }

    func value<T: Decodable>(forKey key: String) -> T? {
        return store[key] as? T
    }
}
