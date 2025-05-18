//
//  StockListComponent.swift
//  StockHomework
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import SwiftUI
import NetworkClient
import NetworkClientImpl
import SystemConfiguration
import StockList
import StocksRepository
import StocksRepositoryImpl
import GetStockListImpl

internal struct StockListComponent {

    let networkClient: NetworkClient
    let stocksRepository: StocksRepository

    init() {
        networkClient = ConfigurableNetworkClient(
            session: .shared,
            requestSerializer: JSONRequestSerializer(),
            responseSerializer: JSONResponseSerializer(),
            endpointConfiguration: APIEndpointConfiguration()
        )
        stocksRepository = StocksRepositoryImpl()
    }

    @MainActor
    func makeStockList() -> some View {
        let viewModel = StockListViewModel(
            dependencies: .init(
                getStockList: GetStockListImpl(
                    networkClient: networkClient,
                    stocksRepository: stocksRepository
                ),
                stocksRepository: stocksRepository
            )
        )

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
