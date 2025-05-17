//
//  File.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Combine
import Domain
import GetStockList

public struct GetStockListImpl: GetStockList {
    
    public init () {}

    public func callAsFunction() -> AnyPublisher<[Stock], any Error> {
        Just(
            [
                Stock(
                    symbol: "AAPL",
                    name: "Apple Inc.",
                    previousClose: 150.0,
                    lastClose: 155.0,
                    percentChange: 3.33
                ),
                .init(
                    symbol: "GOOGL",
                    name: "Alphabet Inc.",
                    previousClose: 2800.0,
                    lastClose: 2780.0,
                    percentChange: -0.71
                ),
                .init(
                    symbol: "AMZN",
                    name: "Amazon.com Inc.",
                    previousClose: 3400.0,
                    lastClose: 3350.0,
                    percentChange: -1.47
                ),
            ]
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
