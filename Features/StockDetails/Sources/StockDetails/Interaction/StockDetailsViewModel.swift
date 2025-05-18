//
//  StockDetailsViewModel.swift
//  StockDetails
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import ArchitectureKit
import Combine
import Domain

public final class StockDetailsViewModel: ViewModel<StockDetailsState, StockDetailsActions> {

    private let dependencies: Dependencies
    private let events = PassthroughSubject<StockDetailsEvents, Never>()

    private var cancellables = Set<AnyCancellable>()

    public init(
        stockSymbol: String,
        dependencies: Dependencies
    ) {
        self.dependencies = dependencies

        let updateStock = dependencies.stocksRepository.stocks
            .first()
            .compactMap { $0.first(where: { $0.symbol == stockSymbol }) }
            .map(StockDetailsEvents.didFetchStock)

        super.init(
            initial: .init(),
            dataEvents: events.merge(with: updateStock),
            reducer: Self.reduce
        )

        send(.fetchStockDetails(stockSymbol: stockSymbol))
    }

    static func reduce(
        state: StockDetailsState,
        event: StockDetailsEvents
    ) -> StockDetailsState {
        var state = state
        state.error = nil
        switch event {
        case .didFetchStock(let stock):
            state.stock = stock
        case .didFetchStockDetails(let stockDetails):
            state.stockDetails = stockDetails
        case .didStartFetchingDetails:
            state.isLoading = true
        case .didFailFetchDetails(let error):
            state.error = error
            state.isLoading = false
        }
        return state
    }

    public override func send(_ action: StockDetailsActions) {
        switch action {
        case .fetchStockDetails(let symbol):
            dependencies.getStockDetails(for: symbol)
                .map(StockDetailsEvents.didFetchStockDetails)
                .prepend(.didStartFetchingDetails)
                .catch { Just(StockDetailsEvents.didFailFetchDetails($0)) }
                .sink(receiveValue: events.send)
                .store(in: &cancellables)
        }
    }
}
