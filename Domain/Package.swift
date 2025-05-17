// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Domain",
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]),
    ],
    targets: [
        .target(name: "Domain"),
    ]
)
