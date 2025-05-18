//
//  File.swift
//  StockDetails
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import SwiftUI
import ArchitectureKit
import GetStockDetails
import CommonUI
import Domain

public struct StockDetailsView: View {

    @StateObject private var viewModel: ViewModel<StockDetailsState, StockDetailsActions>

    public init(viewModel: ViewModel<StockDetailsState, StockDetailsActions>) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        if let stock = viewModel.state.stock {
            VStack(spacing: 16) {
                renderStockHeader(for: stock)

                if let details = viewModel.state.stockDetails {
                    renderPrimaryStats(for: details)
                    renderMarketCap(for: details)
                    renderVolume(for: details)
                } else if viewModel.state.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.state.error {
                    Text(description(for: error))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }

    @ViewBuilder private func renderStockHeader(for stock: Stock) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(stock.name)
                .font(.title2)

            Text(stock.symbol)
                .font(.subheadline)

            HStack(spacing: 8) {
                Text(String(format: "$%.2f", stock.previousClose))
                    .font(.headline)
                    .monospacedDigit()

                Spacer()

                if let change = stock.percentChange {
                    PercentChangeView(change: change)
                }
            }
        }
        Divider()
    }

    @ViewBuilder private func renderPrimaryStats(for stock: StockDetails) -> some View {
        SectionView {
            if let openPrice = stock.openPrice {
                SingleDetailsRow(title: "Open:", description: openPrice.asCurrency)
            }
            if let previousClose = stock.previousClose {
                SingleDetailsRow(title: "Previous close:", description: previousClose.asCurrency)
            }
            if let dayRange = stock.dayRange {
                SingleDetailsRow(title: "Day range:", description: dayRange)
            }
            if let week52Range = stock.week52Range {
                SingleDetailsRow(title: "Week 52 range:", description: week52Range)
            }
        }
    }

    @ViewBuilder private func renderMarketCap(for stock: StockDetails) -> some View {
        SectionView {
            if let marketCap = stock.marketCap {
                SingleDetailsRow(title: "Market Cap:", description: marketCap.asCurrency)
            }
        }
    }
    @ViewBuilder private func renderVolume(for stock: StockDetails) -> some View {
        SectionView {
            if let volume = stock.volume {
                SingleDetailsRow(title: "Volume:", description: volume.asCurrency)
            }
        }
    }
}

private extension StockDetailsView {

    func description(for error: GetStockDetailsError) -> String {
        switch error {
        case .cantFindDetails:
            "Can't find a details for stock"
        case .general(let error):
            error.localizedDescription
        }
    }
}
