//
//  File.swift
//  StockDetails
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import Domain
import GetStockDetails

public struct StockDetailsState {
    var stock: Stock?
    var stockDetails: StockDetails?
    var isLoading = false
    var error: GetStockDetailsError?
}
