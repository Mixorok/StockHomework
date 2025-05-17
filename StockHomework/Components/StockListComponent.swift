//
//  StockListComponent.swift
//  StockHomework
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import SwiftUI
import StockList
import GetStockListImpl

internal struct StockListComponent {

    @MainActor
    func makeStockList() -> some View {
        let viewModel = StockListViewModel(dependencies: .init(getStockList: GetStockListImpl()))

        return StockListView(
            viewModel: viewModel,
            view: { routing in
                switch routing {
                case .stockDetail(let stockSymbol):
                    makeStockDetails(for: stockSymbol)
                }
            }
        )
    }

    private func makeStockDetails(for stockSymbol: String) -> some View {
        EmptyView()
    }
}
