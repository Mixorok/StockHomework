// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "FrontendAPI",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "FrontendAPI",
            targets: ["StocksGateway"]
        ),
        .library(
            name: "FrontendAPIImpl",
            targets: ["StocksGatewayImpl"]
        ),
    ],
    dependencies: [.package(path: "../Services")],
    targets: [
        .target(name: "StocksGateway"),
        .target(
            name: "StocksGatewayImpl",
            dependencies: [
                "StocksGateway",
                .product(name: "Services", package: "Services"),
            ]
        ),
    ]
)
