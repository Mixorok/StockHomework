//
//  StockListComponent.swift
//  StockHomework
//
//  Created by Maksim Bezdrobnoi on 17.05.2025.
//

import SwiftUI
import NetworkClient
import NetworkClientImpl
import StockList
import GetStockListImpl

internal struct StockListComponent {

    let networkClient: NetworkClient

    init() {
        networkClient = ConfigurableNetworkClient(
            session: .shared,
            requestSerializer: JSONRequestSerializer(),
            responseSerializer: JSONResponseSerializer(),
            endpointConfiguration: APIEndpointConfiguration()
        )

    }

    @MainActor
    func makeStockList() -> some View {
        let viewModel = StockListViewModel(
            dependencies: .init(
                getStockList: GetStockListImpl(
                    networkClient: networkClient
                )
            )
        )

        return StockListView(
            viewModel: viewModel,
            view: { routing in
                switch routing {
                case .stockDetail(let stockSymbol):
                    makeStockDetails(for: stockSymbol)
                }
            }
        )
    }

    private func makeStockDetails(for stockSymbol: String) -> some View {
        EmptyView()
    }
}

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
