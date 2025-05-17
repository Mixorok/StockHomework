// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Services",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Services",
            targets: [
                "NetworkClient",
                "NetworkClientImpl",
            ]
        ),
    ],
    targets: [
        .target(name: "NetworkClient"),
        .target(
            name: "NetworkClientImpl",
            dependencies: ["NetworkClient"]
        ),
    ]
)
