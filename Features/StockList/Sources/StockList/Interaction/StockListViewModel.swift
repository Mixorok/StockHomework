//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import ArchitectureKit
import Combine
import Domain
import Foundation

public final class StockListViewModel: ViewModel<StockListState, StockListActions> {

    private let dependencies: Dependencies
    private let events = PassthroughSubject<StockListEvents, Never>()

    private var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable?

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies

        let updateStocks = dependencies.stocksRepository.stocks
            .map(StockListEvents.didFetchStocks)

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
                if !stocks.isEmpty {
                    state.isInitialLoading = false
                }
            case .didFailToFetchStocks(let error):
                state.error = error.localizedDescription
                state.isLoading = false
                state.isInitialLoading = true
            case .didStartFetchingStocks:
                if state.isInitialLoading {
                    state.isLoading = true
                }
            case .didOpenStockDetail(let stockSymbol):
                state.selectedStock = stockSymbol
            }
            return state
        }

        super.init(
            initial: .init(),
            dataEvents: events.merge(with: updateStocks),
            reducer: reduce
        )

        send(.fetchStocks)
        startTimer()
    }

    public override func send(_ action: StockListActions) {
        switch action {
        case .fetchStocks:
            dependencies.getStockList()
                .map { _ -> StockListEvents in }
                .prepend(.didStartFetchingStocks)
                .catch { Just(StockListEvents.didFailToFetchStocks($0)) }
                .sink(receiveValue: events.send)
                .store(in: &cancellables)

        case .openStockDetail(stockSymbol: let stockSymbol):
            events.send(.didOpenStockDetail(stockSymbol: stockSymbol))
        }
    }
}

private extension StockListViewModel {

    // Need to understand should we cancel timer on error or not
    func startTimer() {
        timerCancellable = Timer
            .publish(every: 8, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in send(.fetchStocks) }
    }
}
