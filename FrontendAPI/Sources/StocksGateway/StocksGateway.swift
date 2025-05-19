import Combine

public protocol StocksGateway {
    func fetchStocks() -> AnyPublisher<[StockResultDTO], Error>
    func fetchStockDetails(for stockName: String) -> AnyPublisher<StockDetailsDTO?, Error>
}
