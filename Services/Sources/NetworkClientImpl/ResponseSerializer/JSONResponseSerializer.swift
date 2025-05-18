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
        }catch {
                print("❌ Decode failed:", error)
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("🔑 Key '\(key.stringValue)' not found:", context.debugDescription)
                        print("   codingPath:", context.codingPath)
                    case .typeMismatch(let type, let context):
                        print("📐 Type mismatch for type \(type):", context.debugDescription)
                        print("   codingPath:", context.codingPath)
                    case .valueNotFound(let type, let context):
                        print("📭 Value \(type) was expected but not found:", context.debugDescription)
                        print("   codingPath:", context.codingPath)
                    case .dataCorrupted(let context):
                        print("🧨 Data corrupted:", context.debugDescription)
                        print("   codingPath:", context.codingPath)
                    @unknown default:
                        print("🌀 Unknown decoding error:", decodingError)
                    }
                } else {
                    print("⚠️ Other error:", error)
                }
                throw NetworkClientError.responseSerializationError(error)
            }
    }
}
