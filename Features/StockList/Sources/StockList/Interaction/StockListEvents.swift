//
//  File.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Domain

public enum StockListEvents {
    case didFetchStocks([Stock])
    case didFailToFetchStocks(Error)
    case didStartFetchingStocks
    case didOpenStockDetail(stockSymbol: String)
    case dismissDetails
    case didChangeSearchInput(searchText: String)
}
