//
//  File.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Combine
import Domain
import StocksRepository
import GetStockList
import StocksGateway

public struct GetStockListImpl: GetStockList {

    private let stocksGateway: StocksGateway
    private let stocksRepository: StocksRepository

    public init (
        stocksGateway: StocksGateway,
        stocksRepository: StocksRepository
    ) {
        self.stocksGateway = stocksGateway
        self.stocksRepository = stocksRepository
    }

    public func callAsFunction() -> AnyPublisher<Never, Error> {
        stocksGateway.fetchStocks()
            .map { results in
                results.map { response in
                    Stock(
                        symbol: response.symbol,
                        name: response.fullExchangeName,
                        previousClose: response.spark.previousClose,
                        percentChange: response.percentChange
                    )

                }
            }
            .handleEvents(receiveOutput: stocksRepository.updateStocks)
            .ignoreOutput()
            .eraseToAnyPublisher()
    }
}

private extension StockResultDTO {

    var percentChange: Double? {
        guard let lastClose = spark.close?.last(where: { $0 != nil }) as? Double else { return nil }
        let change = spark.previousClose - lastClose
        return (change / lastClose) * 100
    }
}

