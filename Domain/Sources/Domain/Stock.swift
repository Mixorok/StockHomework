//
//  Stock.swift
//  Domain
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

public struct Stock {

    public let symbol: String
    public let name: String
    public let previousClose: Double
    public let percentChange: Double?

    public init(
        symbol: String,
        name: String,
        previousClose: Double,
        percentChange: Double?
    ) {
        self.symbol = symbol
        self.name = name
        self.previousClose = previousClose
        self.percentChange = percentChange
    }
}
