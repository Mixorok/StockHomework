//
//  APIEndpointConfiguration.swift
//  Infrastructure
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//

import NetworkClient
import Foundation

public struct APIEndpointConfiguration: EndpointConfiguration {

    public init() {}

    public func url(
        applying path: String,
        queryItems: [URLQueryItem]
    ) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "yh-finance.p.rapidapi.com"
        components.path = "/\(path)"
        components.queryItems = queryItems
        + [.init(name: "region", value: "US")]
        return components.url
    }

    public func configureRequest(
        url: URL,
        method: HTTPMethod,
        body: Data?
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue(
            "c09ba6fd47msh410923876a79afap14a540jsnfc3f6e79749f",
            forHTTPHeaderField: "x-rapidapi-key"
        )
        request.setValue("yh-finance.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        return request
    }
}
