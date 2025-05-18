//
//  File.swift
//  Domain
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

public struct StockDetails {

    public let openPrice: Double?
    public let previousClose: Double?
    public let volume: Double?
    public let dayRange: String?
    public let week52Range: String?
    public let marketCap: Double?

    public init(
        openPrice: Double?,
        previousClose: Double?,
        volume: Double?,
        dayRange: String?,
        week52Range: String?,
        marketCap: Double?,
    ) {
        self.openPrice = openPrice
        self.previousClose = previousClose
        self.volume = volume
        self.dayRange = dayRange
        self.week52Range = week52Range
        self.marketCap = marketCap
    }
}
