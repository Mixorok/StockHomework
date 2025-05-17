// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "StockList",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "StockList",
            targets: ["StockList"]
        ),
    ],
    targets: [.target(name: "StockList")]
)
