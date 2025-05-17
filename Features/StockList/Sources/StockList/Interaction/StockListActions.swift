//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Domain

public enum StockListActions {
    case fetchStocks
    case openStockDetail(stockSymbol: String)
}
