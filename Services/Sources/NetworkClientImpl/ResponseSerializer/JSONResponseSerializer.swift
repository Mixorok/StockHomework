//
//  JSONResponseSerializer.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Foundation
import NetworkClient

public struct JSONResponseSerializer: ResponseSerializer {

    private let decoder = JSONDecoder()

    public init() {}

    public func decode<T: Decodable>(_ type: T.Type, from dataPayload: DataPayload) throws -> T {
        do {
            return try decoder.decode(type, from: dataPayload.data)
        } catch let error {
            throw NetworkClientError.responseSerializationError(error)
        }
    }
}
