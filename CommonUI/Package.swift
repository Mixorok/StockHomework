// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "CommonUI",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "CommonUI",
            targets: ["CommonUI"]
        ),
    ],
    targets: [.target(name: "CommonUI")]
)
