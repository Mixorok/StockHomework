//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import SwiftUI
import Domain
import ArchitectureKit

public struct StockListView<RoutingView: View>: View {

    @StateObject private var viewModel: ViewModel<StockListState, StockListActions>

    private let view: (Routing) -> RoutingView

    public init(
        viewModel: ViewModel<StockListState, StockListActions>,
        @ViewBuilder view: @escaping (Routing) -> RoutingView
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.view = view
    }

    public var body: some View {
        ZStack {
            List(viewModel.state.stocks, id: \.symbol) { stock in
                SingleStockView(
                    stock: stock,
                    openStockDetails: { viewModel.send(.openStockDetail(stockSymbol: $0)) }
                )
            }

            if viewModel.state.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let error = viewModel.state.error {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationTitle("Stocks")
    }
}
