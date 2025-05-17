//
//  RequestSerializer.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Foundation

public protocol RequestSerializer {
    func encode<T: Encodable>(_ value: T) throws -> Data
    func configureContentType(on urlRequest: URLRequest) -> URLRequest
}
