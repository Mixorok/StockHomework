//
//  GetStockDetails.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Combine
import Domain

public enum GetStockDetailsError: Error {
    case cantFindDetails
    case general(Error)
}

public protocol GetStockDetails {
    func callAsFunction(for stockName: String) -> AnyPublisher<StockDetails, GetStockDetailsError>
}
