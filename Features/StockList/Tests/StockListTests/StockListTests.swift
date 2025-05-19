//
//  StockListTests.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 19.05.2025.
//

@testable import StockList
import Domain
import Combine
import GetStockList
import StocksRepository
import XCTest

@MainActor
final class StockListTests: XCTestCase {

    func testInitialLoadSuccess() {
        let stocks = [
            Stock(symbol: "APPL", name: "Apple Inc.", previousClose: 100, percentChange: 1.0)
        ]
        let stocksRepository = StocksRepositoryMock()
        stocksRepository._stocks.send(stocks)
        let viewModel = makeViewModel(stocksRepository: stocksRepository)

        let exp = expectation(description: "Stocks loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.state.stocks, stocks)
            XCTAssertFalse(viewModel.state.isLoading)
            XCTAssertFalse(viewModel.state.isInitialLoading)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testOpenAndDismissStockDetail() {
        let viewModel = makeViewModel()

        viewModel.send(.openStockDetail(stockSymbol: "APPL"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.state.selectedStock, "APPL")
        }

        viewModel.send(.dismissDetails)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(viewModel.state.selectedStock)
        }
    }

    func testChangeSearchInput() {
        let viewModel = makeViewModel()

        viewModel.send(.changeSearchInput(searchText: "test"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.state.searchInput, "test")
        }
    }

    private func makeViewModel(
        stocksRepository: StocksRepository = StocksRepositoryMock()
    ) -> StockListViewModel {
        StockListViewModel(
            dependencies: .init(
                getStockList: GetStockListMock(),
                stocksRepository: stocksRepository,
                routeToDirection: { _ in }
            )
        )
    }
}

private struct GetStockListMock: GetStockList {

    func callAsFunction() -> AnyPublisher<Never, Error> {
        Empty().eraseToAnyPublisher()
    }
}

private struct StocksRepositoryMock: StocksRepository {

    var stocks: AnyPublisher<[Stock], Never> {
        _stocks.eraseToAnyPublisher()
    }

    var _stocks = CurrentValueSubject<[Stock], Never>([])

    func updateStocks(to stocks: [Stock]) {}
}
