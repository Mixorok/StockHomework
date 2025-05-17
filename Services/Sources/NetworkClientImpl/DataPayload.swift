//
//  DataPayload.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Foundation

public struct DataPayload {

    public let data: Data
    public let urlRequest: URLRequest

    public init(data: Data, urlRequest: URLRequest) {
        self.data = data
        self.urlRequest = urlRequest
    }
}
