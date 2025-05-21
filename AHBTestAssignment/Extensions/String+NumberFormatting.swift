//
//  Double+Abbreviated.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import Foundation

extension String {
    private static let formatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }()

    func abbreviatedNumber() -> String {
        guard let number = Double(self) else { return self }

        switch number {
        case 1_000_000_000...:
            return String(format: "%.2fB", number / 1_000_000_000)
        case 1_000_000...:
            return String(format: "%.2fM", number / 1_000_000)
        case 1_000...:
            return String(format: "%.2fK", number / 1_000)
        default:
            return String(format: "%.4f", number)
        }
    }
}
