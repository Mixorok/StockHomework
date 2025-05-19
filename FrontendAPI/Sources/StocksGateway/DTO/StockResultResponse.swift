//
//  StockListResponse.swift
//  FrontendAPI
//
//  Created by Maksim Bezdrobnoi on 19.05.2025.
//


public struct StockResultDTO: Decodable {
    public let fullExchangeName: String
    public let symbol: String
    public let spark: SparkResponse
}

public struct SparkResponse: Decodable {
    public let previousClose: Double
    public let close: [Double?]?
}
