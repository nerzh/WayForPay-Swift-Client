// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WFPClient",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "WFPClient",
            targets: ["WFPClient"]),
    ],
    dependencies: [
        .package(name: "SwiftExtensionsPack", url: "https://github.com/nerzh/swift-extensions-pack.git", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "WFPClient",
            dependencies: [
                .product(name: "SwiftExtensionsPack", package: "SwiftExtensionsPack"),
            ]
        )
    ]
)
