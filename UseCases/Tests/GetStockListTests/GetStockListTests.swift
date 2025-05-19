//
//  GetStockListTests.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 19.05.2025.
//

@testable import GetStockListImpl
import XCTest
import Domain
import Combine
import StocksRepository
@testable import StocksGateway

final class GetStockListTests: XCTestCase {

    private let stocksRepository = StocksRepositoryMock()

    private lazy var getStockListImpl = GetStockListImpl(
        stocksGateway: StocksGatewayFake(),
        stocksRepository: stocksRepository
    )

    var cancellable = Set<AnyCancellable>()

    func testCorrectSendStocksData() {
        let expectations: [Stock] = [
            Stock(
                symbol: "APPL",
                name: "Apple Inc.",
                previousClose: 150.0,
                percentChange: 1.3513513513513513
            ),
            Stock(
                symbol: "MSFT",
                name: "Microsoft Corp.",
                previousClose: 250.0,
                percentChange: 0.8064516129032258
            ),
        ]
        stocksRepository.updateStocks(to: expectations)

        let exp = expectation(description: "Stocks sent to repository")
        var result: [Stock] = []
        stocksRepository.stocks
            .dropFirst()
            .sink { stocks in
                result = stocks
                exp.fulfill()
            }
            .store(in: &cancellable)

        getStockListImpl.callAsFunction()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { _ in }
            )
            .store(in: &cancellable)

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(result, expectations)
    }
}

private class StocksRepositoryMock: StocksRepository {

    var stocks: AnyPublisher<[Stock], Never> {
        _stocks.eraseToAnyPublisher()
    }

    private let _stocks = CurrentValueSubject<[Stock], Never>([])

    func updateStocks(to stocks: [Domain.Stock]) {
        _stocks.send(stocks)
    }
}

private struct StocksGatewayFake: StocksGateway {

    func fetchStocks() -> AnyPublisher<[StockResultDTO], Error> {
        Just([StockResultDTO].mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchStockDetails(for stockName: String) -> AnyPublisher<StockDetailsDTO?, Error> {
        fatalError("Doesn't need to this test")
    }
}

private extension [StockResultDTO] {

    static var mock: [StockResultDTO] {
        [
            StockResultDTO(
                fullExchangeName: "Apple Inc.",
                symbol: "APPL",
                spark: .init(
                    previousClose: 150.0,
                    close: [149.5, 148.0]
                )
            ),
            StockResultDTO(
                fullExchangeName: "Microsoft Corp.",
                symbol: "MSFT",
                spark: .init(
                    previousClose: 250.0,
                    close: [249.5, 248.0]
                )
            ),
        ]
    }
}
