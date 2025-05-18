//
//  File.swift
//  StockDetails
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import GetStockDetails
import StocksRepository

public extension StockDetailsViewModel {

    struct Dependencies {

        let getStockDetails: GetStockDetails
        let stocksRepository: StocksRepository

        public init(getStockDetails: GetStockDetails, stocksRepository: StocksRepository) {
            self.getStockDetails = getStockDetails
            self.stocksRepository = stocksRepository
        }
    }
}
