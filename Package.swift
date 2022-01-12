// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mbientSwiftUI",
    platforms: [.macOS(.v11), .iOS(.v14), .watchOS(.v7), .tvOS(.v14)],
    products: [
        .library(name: "mbientSwiftUI",targets: ["mbientSwiftUI"]),
    ],
    dependencies: [.package(name: "MetaWear", url: "https://github.com/mbientlab/MetaWear-SDK-Swift-Combine.git", branch: "main")],
    targets: [
        .target(
            name: "mbientSwiftUI",
            dependencies: [
                .product(name: "MetaWear", package: "MetaWear", condition: nil),
                .product(name: "MetaWearSync", package: "MetaWear", condition: nil)
            ]
        )
    ]
)
