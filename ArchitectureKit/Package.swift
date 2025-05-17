// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "ArchitectureKit",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ArchitectureKit",
            targets: ["ArchitectureKit"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ArchitectureKit"),
        .testTarget(
            name: "ArchitectureKitTests",
            dependencies: ["ArchitectureKit"]
        ),
    ]
)
