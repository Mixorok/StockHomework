//
//  StockDetailsComponent.swift
//  StockHomework
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import SwiftUI
import StockDetails
import GetStockDetailsImpl

internal struct StockDetailsComponent {

    let parent: StockListComponent

    @MainActor
    func makeDetails(for stockSymbol: String) -> some View {
        let viewModel = StockDetailsViewModel(
            stockSymbol: stockSymbol,
            dependencies: .init(
                getStockDetails: GetStockDetailsImpl(stocksGateway: parent.stocksGateway),
                stocksRepository: parent.stocksRepository
            )
        )

        return StockDetailsView(viewModel: viewModel)
    }
}
