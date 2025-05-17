// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ArchitectureKit",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "ArchitectureKit",
            targets: ["ArchitectureKit"]
        ),
    ],
    targets: [.target(name: "ArchitectureKit")]
)
