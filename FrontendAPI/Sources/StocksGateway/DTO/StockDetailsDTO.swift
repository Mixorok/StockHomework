//
//  StockDetailsResponse.swift
//  FrontendAPI
//
//  Created by Maksim Bezdrobnoi on 19.05.2025.
//

public struct StockDetailsDTO: Decodable {
    public let regularMarketPrice: Double?
    public let regularMarketPreviousClose: Double?
    public let regularMarketOpen: Double?
    public let regularMarketDayHigh: Double?
    public let regularMarketDayLow: Double?
    public let regularMarketVolume: Double?
    public let marketCap: Double?
    public let fiftyTwoWeekLow: Double?
    public let fiftyTwoWeekHigh: Double?
}
