//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import GetStockList

public extension StockListViewModel {
    
    struct Dependencies {
        let getStockList: GetStockList
        
        public init(getStockList: GetStockList) {
            self.getStockList = getStockList
        }
    }
}
