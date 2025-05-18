//
//  GetStockDetailsImpl.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Combine
import GetStockDetails
import NetworkClient
import Domain

public struct GetStockDetailsImpl: GetStockDetails {
    
    private let networkClient: NetworkClient

    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    public func callAsFunction(
        for stockName: String
    ) -> AnyPublisher<StockDetails, GetStockDetailsError> {
        networkClient.get(
            StockDetailsResponse.self,
            path: "market/v2/get-quotes",
            queryItems: [.init(name: "symbols", value: stockName)]
        )
        .map(\.quoteResponse.result)
        .tryMap { results in
            guard let response = results.first else {
                throw GetStockDetailsError.cantFindDetails
            }
            return StockDetails(
                openPrice: response.regularMarketOpen,
                previousClose: response.regularMarketPreviousClose,
                volume: response.regularMarketVolume,
                dayRange: response.dayRange,
                week52Range: response.week52Range,
                marketCap: response.marketCap,
            )
        }
        .mapError { $0 as? GetStockDetailsError ?? .general($0) }
        .eraseToAnyPublisher()
    }
}

private extension StockDetailsDTO {

    var dayRange: String? {
        guard let low = regularMarketDayLow, let high = regularMarketDayHigh else { return nil }
        return String(format: "$%.2f - $%.2f", low, high)
    }

    var week52Range: String? {
        guard let low = fiftyTwoWeekLow, let high = fiftyTwoWeekHigh else { return nil }
        return String(format: "$%.2f - $%.2f", low, high)
    }
}

private struct StockDetailsResponse: Decodable {
    let quoteResponse: QuoteResponse
}

private struct QuoteResponse: Decodable {
    let result: [StockDetailsDTO]
}

private struct StockDetailsDTO: Decodable {
    let regularMarketPrice: Double?
    let regularMarketPreviousClose: Double?
    let regularMarketOpen: Double?
    let regularMarketDayHigh: Double?
    let regularMarketDayLow: Double?
    let regularMarketVolume: Double?
    let marketCap: Double?
    let fiftyTwoWeekLow: Double?
    let fiftyTwoWeekHigh: Double?
}
