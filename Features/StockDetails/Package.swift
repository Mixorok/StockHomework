// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "StockDetails",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "StockDetails",
            targets: ["StockDetails"]
        ),
    ],
    targets: [.target(name: "StockDetails")]
)
