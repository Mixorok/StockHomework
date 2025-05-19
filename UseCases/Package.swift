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
        .package(path: "../FrontendAPI"),
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
                .product(name: "FrontendAPI", package: "FrontendAPI"),
                .product(name: "Infrastructure", package: "Infrastructure"),
            ]
        ),
        .target(
            name: "GetStockDetailsImpl",
            dependencies: [
                "Domain",
                "GetStockDetails",
                .product(name: "FrontendAPI", package: "FrontendAPI"),
                .product(name: "Infrastructure", package: "Infrastructure"),
            ]
        ),
        .testTarget(
            name: "GetStockListTests",
            dependencies: [
                "Domain",
                "GetStockListImpl",
                .product(name: "FrontendAPI", package: "FrontendAPI"),
                .product(name: "Infrastructure", package: "Infrastructure"),
            ]
        ),
        .testTarget(
            name: "GetStockDetailsTests",
            dependencies: [
                "Domain",
                "GetStockDetails",
                "GetStockDetailsImpl",
                .product(name: "FrontendAPI", package: "FrontendAPI"),
                .product(name: "Infrastructure", package: "Infrastructure"),
            ]
        ),
    ]
)
