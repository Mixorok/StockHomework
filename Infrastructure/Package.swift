// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Infrastructure",
            targets: [
                "StocksRepository",
                "SystemConfiguration",
            ]
        ),
        .library(
            name: "InfrastructureImpl",
            targets: ["StocksRepositoryImpl"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Services")
    ],
    targets: [
        .target(name: "SystemConfiguration", dependencies: ["Services"]),
        .target(name: "StocksRepository", dependencies: ["Domain"]),
        .target(name: "StocksRepositoryImpl", dependencies: ["Domain", "StocksRepository"]),
    ]
)
