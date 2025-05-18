//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import GetStockList
import StocksRepository

public extension StockListViewModel {
    
    struct Dependencies {

        let getStockList: GetStockList
        let stocksRepository: StocksRepository

        public init(
            getStockList: GetStockList,
            stocksRepository: StocksRepository
        ) {
            self.getStockList = getStockList
            self.stocksRepository = stocksRepository
        }
    }
}
