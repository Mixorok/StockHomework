//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Domain
import SwiftUI

internal struct SingleStockView: View {

    private let stock: Stock
    private let openStockDetails: (String) -> Void

    init(stock: Stock, openStockDetails: @escaping (String) -> Void) {
        self.stock = stock
        self.openStockDetails = openStockDetails
    }

    var body: some View {
        Button(action: { openStockDetails(stock.symbol)}) {
            VStack(alignment: .leading, spacing: 6) {
                Text(stock.name)
                    .font(.title3)

                HStack(spacing: 0) {
                    Text(stock.symbol)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let change = stock.percentChange {
                        HStack(spacing: 2) {
                            Image(systemName: change > 0 ? "arrow.up" : "arrow.down")
                            Text(String(format: "%.2f%%", change))
                        }
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(change > 0 ? .green : .red)
                    }
                }

                if let lastClose = stock.lastClose {
                    Text(String(format: "$%.2f", lastClose))
                        .font(.headline)
                        .monospacedDigit()
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
