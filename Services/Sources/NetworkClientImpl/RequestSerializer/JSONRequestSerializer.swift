//
//  JSONRequestSerializer.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Foundation
import NetworkClient

public struct JSONRequestSerializer: RequestSerializer {

    private let encoder = JSONEncoder()

    public init() {}

    public func encode(_ value: some Encodable) throws -> Data {
        do {
            return try encoder.encode(value)
        } catch let error {
            throw NetworkClientError.requestSerializer(error)
        }
    }

    public func configureContentType(on urlRequest: URLRequest) -> URLRequest {
        var request = urlRequest
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        return request
    }
}

private extension Error {

    var asDebugDescription: String? {
        guard let err = self as? EncodingError else {
            return nil
        }
        switch err {
        case .invalidValue(_, let context):
            return context.debugDescription
        @unknown default:
            return nil
        }
    }
}
