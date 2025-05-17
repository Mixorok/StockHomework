//
//  File.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Combine
import Foundation

public extension NetworkClient {

    func get<ResponseBody: Decodable>(
        _ responseType: ResponseBody.Type,
        path: String,
        queryItems: [URLQueryItem] = []
    ) -> AnyPublisher<ResponseBody, Error> {
        execute(
            method: .get,
            path: path,
            queryItems: queryItems,
            body: EmptyRequestEntity?.none,
            responseType: responseType
        )
    }
}

private struct EmptyRequestEntity: Encodable {}
