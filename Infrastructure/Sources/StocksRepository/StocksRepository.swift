//
//  File.swift
//  Infrastructure
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import Combine
import Domain

public protocol StocksRepository {
    var stocks: AnyPublisher<[Stock], Never> { get }
    func updateStocks(to stocks: [Stock])
}
