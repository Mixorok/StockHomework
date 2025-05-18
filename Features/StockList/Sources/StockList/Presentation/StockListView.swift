//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import SwiftUI
import Domain
import ArchitectureKit

public struct StockListView: View {

    @StateObject private var viewModel: ViewModel<StockListState, StockListActions>
    @StateObject private var router: BaseRouter<StockListRouter>

    public init(
        viewModel: ViewModel<StockListState, StockListActions>,
        router: BaseRouter<StockListRouter>
    ) {
        _viewModel =  StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
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
        .navigationDestination(
            item: Binding(
                get: { viewModel.state.selectedStock },
                set: { _ in viewModel.send(.dismissDetails)}
            )
        ) { selectedStock in
            router.view(for: .stockDetail(stockSymbol: selectedStock))
        }
    }
}
