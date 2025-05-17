//
//  NetworkClient.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Foundation
import Combine

public protocol NetworkClient {

    func execute<RequestBody: Encodable, ResponseBody: Decodable>(
            method: HTTPMethod,
            path: String,
            queryItems: [URLQueryItem],
            body: RequestBody?,
            responseType: ResponseBody.Type
        ) -> AnyPublisher<ResponseBody, Error>
}
