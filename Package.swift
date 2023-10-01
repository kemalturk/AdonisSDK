// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdonisSDK",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AdonisSDK",
            targets: ["AdonisSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/kemalturk/HttpKit.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AdonisSDK",
            dependencies: ["HttpKit", "SDWebImage"]
        ),
        .testTarget(
            name: "AdonisSDKTests",
            dependencies: ["AdonisSDK"]),
    ]
)
