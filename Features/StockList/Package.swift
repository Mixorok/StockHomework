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
        .package(path: "../Infrastructure"),
        .package(path: "../CommonUI"),
    ],
    targets: [
        .target(
            name: "StockList",
            dependencies: [
                "Domain",
                "ArchitectureKit",
                "CommonUI",
                .product(name: "UseCases", package: "UseCases"),
                .product(name: "Infrastructure", package: "Infrastructure")
            ],
        ),
        .testTarget(
            name: "StockListTests",
            dependencies: [
                "Domain",
                "StockList",
                .product(name: "UseCases", package: "UseCases"),
                .product(name: "Infrastructure", package: "Infrastructure")
            ]
        ),
    ]
)
