// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mbientSwiftUI",
    platforms: [.macOS(.v11), .iOS(.v13), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(
            name: "mbientSwiftUI",
            targets: ["mbientSwiftUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "mbientSwiftUI",
            dependencies: [])
    ]
)
