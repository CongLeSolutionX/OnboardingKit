// swift-tools-version: 5.6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OnboardingKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "OnboardingKit",
            targets: ["OnboardingKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/snapkit/snapkit", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "OnboardingKit",
            dependencies: [
                .product(name: "SnapKit", package: "snapkit")
            ]),
        .testTarget(
            name: "OnboardingKitTests",
            dependencies: ["OnboardingKit"]),
    ]
)
