import SwiftUI
import ArchitectureKit

public final class StockListRouting: BaseRouter<StockListRouter> {

    private let routeToDetails: (String) -> AnyView

    public init(routeToDetails: @escaping (String) -> AnyView) {
        self.routeToDetails = routeToDetails
        super.init()
    }

    public override func route(to direction: StockListRouter) {
        switch direction {
        case .stockDetail(let stockSymbol):
            set(view: routeToDetails(stockSymbol), for: direction)
        }
    }
}
