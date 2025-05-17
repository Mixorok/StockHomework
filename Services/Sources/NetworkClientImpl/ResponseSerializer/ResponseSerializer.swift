//
//  ResponseSerializer.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Foundation

public protocol ResponseSerializer {
    func decode<T: Decodable>(_ type: T.Type, from data: DataPayload) throws -> T
}
