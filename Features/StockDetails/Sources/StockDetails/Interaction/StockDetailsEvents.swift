//
//  StockDetailsEvents.swift
//  StockDetails
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import Domain
import GetStockDetails

public enum StockDetailsEvents {
    case didFetchStock(Stock)
    case didFetchStockDetails(StockDetails)
    case didStartFetchingDetails
    case didFailFetchDetails(GetStockDetailsError)
}
