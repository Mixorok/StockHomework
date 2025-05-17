// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "UseCases",
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
        .package(path: "../Domain")],
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
            dependencies: ["Domain", "GetStockList"]
        ),
        .target(
            name: "GetStockDetailsImpl",
            dependencies: ["Domain", "GetStockDetails"]
        ),
    ]
)
