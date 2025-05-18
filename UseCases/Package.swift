// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "UseCases",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "UseCases",
            targets: [
                "GetStockList",
                "GetStockDetails",
                ]
        ),
        .library(
            name: "UseCasesImpl",
            targets: [
                "GetStockListImpl",
                "GetStockDetailsImpl",
            ]
        )
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Services"),
        .package(path: "../Infrastructure")
    ],
    targets: [
        .target(
            name: "GetStockList",
            dependencies: ["Domain"]
        ),
        .target(
            name: "GetStockDetails",
            dependencies: ["Domain"]
        ),
        .target(
            name: "GetStockListImpl",
            dependencies: [
                "Domain",
                "GetStockList",
                .product(name: "Services", package: "Services"),
                .product(name: "Infrastructure", package: "Infrastructure"),
            ]
        ),
        .target(
            name: "GetStockDetailsImpl",
            dependencies: [
                "Domain",
                "GetStockDetails",
                .product(name: "Services", package: "Services"),
                .product(name: "Infrastructure", package: "Infrastructure"),
            ]
        ),
    ]
)
