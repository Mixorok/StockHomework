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
    dependencies: [
        .package(path: "../ArchitectureKit"),
        .package(path: "../Domain"),
        .package(path: "../UseCases"),
    ],
    targets: [
        .target(
            name: "StockList",
            dependencies: [
                "Domain",
                "ArchitectureKit",
                .product(name: "UseCases", package: "UseCases")
            ],
        )
    ]
)
