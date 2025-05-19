//
//  StockListComponent.swift
//  StockHomework
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import SwiftUI
import NetworkClient
import NetworkClientImpl
import StocksGateway
import StocksGatewayImpl
import SystemConfiguration
import StockList
import StocksRepository
import StocksRepositoryImpl
import GetStockListImpl

internal struct StockListComponent {

    let stocksGateway: StocksGateway
    let stocksRepository: StocksRepository

    init() {
        let networkClient = ConfigurableNetworkClient(
            session: .shared,
            requestSerializer: JSONRequestSerializer(),
            responseSerializer: JSONResponseSerializer(),
            endpointConfiguration: APIEndpointConfiguration()
        )
        stocksGateway = StocksGatewayImpl(networkClient: networkClient)
        stocksRepository = StocksRepositoryImpl()
    }

    @MainActor
    func makeStockList() -> some View {
        let router = StockListRouting(routeToDetails: makeStockDetails)
        let viewModel = StockListViewModel(
            dependencies: .init(
                getStockList: GetStockListImpl(
                    stocksGateway: stocksGateway,
                    stocksRepository: stocksRepository
                ),
                stocksRepository: stocksRepository,
                routeToDirection: router.route
            )
        )

        return StockListView(
            viewModel: viewModel,
            router: router
        )
    }

    @MainActor
    private func makeStockDetails(for stockSymbol: String) -> AnyView {
        AnyView(StockDetailsComponent(parent: self).makeDetails(for: stockSymbol))
    }
}
