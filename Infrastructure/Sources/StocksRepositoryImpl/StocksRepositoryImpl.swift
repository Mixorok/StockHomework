import Combine
import Domain
import StocksRepository

public class StocksRepositoryImpl: StocksRepository {

    public var stocks: AnyPublisher<[Stock], Never> {
        _stocks.eraseToAnyPublisher()
    }

    private let _stocks = CurrentValueSubject<[Stock], Never>([])

    public init() {}

    public func updateStocks(to stocks: [Stock]) {
        _stocks.send(stocks)
    }
}
