//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import ArchitectureKit
import Combine
import Domain

public final class StockListViewModel: ViewModel<StockListState, StockListActions> {

    private let dependencies: Dependencies
    private let events = PassthroughSubject<StockListEvents, Never>()

    private var cancellables = Set<AnyCancellable>()

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies


        func reduce(
            state: StockListState,
            event: StockListEvents
        ) -> StockListState {
            var state = state
            state.error = nil
            switch event {
            case .didFetchStocks(let stocks):
                state.stocks = stocks
                state.isLoading = false
            case .didFailToFetchStocks(let error):
                state.error = error.localizedDescription
                state.isLoading = false
            case .didStartFetchingStocks:
                state.isLoading = true
            case .didOpenStockDetail(let stockSymbol):
                state.selectedStock = stockSymbol
            }
            return state
        }

        super.init(
            initial: .init(),
            dataEvents: events,
            reducer: reduce
        )

        send(.fetchStocks)
    }

    public override func send(_ action: StockListActions) {
        switch action {
        case .fetchStocks:
            dependencies.getStockList()
                .map(StockListEvents.didFetchStocks)
                .prepend(.didStartFetchingStocks)
                .catch { Just(StockListEvents.didFailToFetchStocks($0)) }
                .sink(receiveValue: events.send)
                .store(in: &cancellables)

        case .openStockDetail(stockSymbol: let stockSymbol):
            events.send(.didOpenStockDetail(stockSymbol: stockSymbol))
        }
    }
}
