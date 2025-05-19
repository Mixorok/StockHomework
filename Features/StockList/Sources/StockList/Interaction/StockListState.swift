import Domain

public struct StockListState {
    var stocks: [Stock] = []
    var isLoading = false
    var error: String?
    var selectedStock: String?
    var isInitialLoading = true
    var searchInput: String = ""
}

extension StockListState {

    var filteredStocks: [Stock] {
        guard !searchInput.isEmpty else { return stocks }
        return stocks.filter { $0.name.lowercased().contains(searchInput.lowercased()) }
    }
}
