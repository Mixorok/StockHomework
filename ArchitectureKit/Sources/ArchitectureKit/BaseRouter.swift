//
//  BaseRouter.swift
//  StockList
//
//  Created by Maksim Bezdrobnoi on 18.05.2025.
//


import SwiftUI

open class BaseRouter<Direction: Hashable>: ObservableObject {

    public typealias RoutingToken = Int

    @Published public private(set) var routers: [RoutingToken: AnyView] = [:]

    public init() {}

    open func route(to direction: Direction) {
        fatalError("Not implemented")
    }

    public func back(from direction: Direction) {
        routers[direction.hashValue] = nil
    }

    public func view(for direction: Direction) -> AnyView {
        routers[direction.hashValue] ?? AnyView(EmptyView())
    }

    @discardableResult
    public func set(
        view: AnyView,
        for direction: Direction
    ) -> RoutingToken {
        let routingToken = direction.hashValue

        if !routers.keys.contains(routingToken) {
            routers[routingToken] = view
        }
        return routingToken
    }
}
