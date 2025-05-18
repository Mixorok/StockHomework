import Domain

public struct StockListState {
    var stocks: [Stock] = []
    var isLoading = false
    var error: String?
    var selectedStock: String?
    var isInitialLoading = true
}
