//
//  PercentChangeView.swift
//  CommonUI
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import SwiftUI

public struct PercentChangeView: View {

    private let change: Double

    public init(change: Double) {
        self.change = change
    }

    public var body: some View {
        HStack(spacing: 2) {
            Image(systemName: change > 0 ? "arrow.up" : "arrow.down")
            Text(String(format: "%.2f%%", change))
        }
        .font(.caption)
        .fontWeight(.bold)
        .foregroundStyle(change > 0 ? .green : .red)
    }
}
