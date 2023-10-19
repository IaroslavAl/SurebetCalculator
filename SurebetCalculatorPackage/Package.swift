// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SurebetCalculatorPackage",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Root",
            targets: ["Root"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Onboarding",
            dependencies: []
        ),
        .target(
            name: "Root",
            dependencies: [
                "Onboarding",
                "SurebetCalculator",
            ]
        ),
        .target(
            name: "SurebetCalculator",
            dependencies: []
        ),
        .testTarget(
            name: "SurebetCalculatorTests",
            dependencies: []
        ),
    ]
)
