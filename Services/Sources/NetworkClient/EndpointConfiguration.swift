//
//  EndpointConfiguration.swift
//  Services
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import Foundation

public protocol EndpointConfiguration {
    func url(applying path: String, queryItems: [URLQueryItem]) -> URL?
    func configureRequest(url: URL, method: HTTPMethod, body: Data?) -> URLRequest
}
