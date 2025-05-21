//
//  UserDefaultsProvider.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import Foundation

protocol UserDefaultsProvider {
    func set<T: Encodable>(_ value: T, forKey key: String)
    func value<T: Decodable>(forKey key: String) -> T?
}
