import StocksGateway
import NetworkClient
import Combine

public struct StocksGatewayImpl: StocksGateway {

    private let networkClient: NetworkClient

    public init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    public func fetchStocks() -> AnyPublisher<[StockResultDTO], Error> {
        networkClient.get(StockListResponse.self, path: "market/v2/get-summary")
            .map(\.marketSummaryAndSparkResponse.result)
            .eraseToAnyPublisher()
    }
    
    public func fetchStockDetails(for stockName: String) -> AnyPublisher<StockDetailsDTO?, Error> {
        networkClient.get(
            StockDetailsResponse.self,
            path: "market/v2/get-quotes",
            queryItems: [.init(name: "symbols", value: stockName)]
        )
        .map(\.quoteResponse.result.first)
        .eraseToAnyPublisher()
    }
    
}

private struct StockListResponse: Decodable {
    let marketSummaryAndSparkResponse: MarketSummaryAndSparkResponse
}

private struct MarketSummaryAndSparkResponse: Decodable {
    let result: [StockResultDTO]
}

private struct StockDetailsResponse: Decodable {
    let quoteResponse: QuoteResponse
}

private struct QuoteResponse: Decodable {
    let result: [StockDetailsDTO]
}
