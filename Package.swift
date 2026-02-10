// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeclareKit",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        .library(name: "DeclareKit", targets: ["DeclareKit"]),
        .library(name: "DeclareKitCore", targets: ["DeclareKitCore"]),
        .library(name: "DeclareKitUIKit", targets: ["DeclareKitUIKit"]),
    ],
    targets: [
        .target(name: "DeclareKitCore"),
        .target(name: "DeclareKitUIKit", dependencies: ["DeclareKitCore"]),
        .target(name: "DeclareKit", dependencies: ["DeclareKitCore", "DeclareKitUIKit"]),
        .testTarget(
            name: "DeclareKitTests",
            dependencies: ["DeclareKit"]
        ),
    ]
)
