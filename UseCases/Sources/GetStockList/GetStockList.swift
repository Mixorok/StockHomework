//
//  File.swift
//  UseCases
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Domain
import Combine

public protocol GetStockList {
    func callAsFunction() -> AnyPublisher<Never, Error>
}
