import Domain

public struct StockListState {
    public var stocks: [Stock] = []
    public var isLoading: Bool = false
    public var error: String?
    public var selectedStock: String?
}

