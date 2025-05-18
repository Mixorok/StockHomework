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
import NetworkClient

public struct GetStockListImpl: GetStockList {

    private let networkClient: NetworkClient
    private let stocksRepository: StocksRepository

    public init (
        networkClient: NetworkClient,
        stocksRepository: StocksRepository
    ) {
        self.networkClient = networkClient
        self.stocksRepository = stocksRepository
    }

    public func callAsFunction() -> AnyPublisher<Never, Error> {
        networkClient.get(StockListResponse.self, path: "market/v2/get-summary")
            .map(\.marketSummaryAndSparkResponse.result)
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

private extension ResultResponse {

    var percentChange: Double? {
        guard let lastClose = spark.close?.last(where: { $0 != nil }) as? Double else { return nil }
        let change = spark.previousClose - lastClose
        return (change / lastClose) * 100
    }
}

private struct StockListResponse: Decodable {
    let marketSummaryAndSparkResponse: MarketSummaryAndSparkResponse
}

private struct MarketSummaryAndSparkResponse: Decodable {
    let result: [ResultResponse]
}

private struct ResultResponse: Decodable {
    let fullExchangeName: String
    let symbol: String
    let spark: SparkResponse
}

private struct SparkResponse: Decodable {
    let previousClose: Double
    let close: [Double?]?
}
