//
//  GetStockDetailsImpl.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Combine
import GetStockDetails
import StocksGateway
import Domain
import Foundation

public struct GetStockDetailsImpl: GetStockDetails {
    
    private let stocksGateway: StocksGateway

    public init(stocksGateway: StocksGateway) {
        self.stocksGateway = stocksGateway
    }

    public func callAsFunction(
        for stockName: String
    ) -> AnyPublisher<StockDetails, GetStockDetailsError> {
        stocksGateway.fetchStockDetails(for: stockName)
            .tryMap { response in
                guard let response else {
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
