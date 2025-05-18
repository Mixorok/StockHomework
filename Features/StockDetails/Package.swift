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
    dependencies: [
        .package(path: "../ArchitectureKit"),
        .package(path: "../Domain"),
        .package(path: "../UseCases"),
        .package(path: "../CommonUI"),
    ],
    targets: [
        .target(
            name: "StockDetails",
            dependencies: [
                "Domain",
                "ArchitectureKit",
                "CommonUI",
                .product(name: "UseCases", package: "UseCases")
            ],
        )
    ]
)
