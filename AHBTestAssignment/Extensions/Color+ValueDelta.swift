//
//  Color+ValueDelta.swift
//  AHBTestAssignment
//
//  Created by Borys Vynohradov on 20.05.2025.
//

import SwiftUI

extension Color {
    static func foregroundColor(forValueDelta delta: String) -> Color {
        guard let number = Double(delta) else { return .gray }

        return number >= 0 ? .green : .red
    }
}
