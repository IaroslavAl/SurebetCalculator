// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SurebetCalculatorPackage",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Root",
            targets: ["Root"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/appmetrica/appmetrica-sdk-ios.git",
            .upToNextMinor(from: "5.4.0")
        ),
        .package(
            url: "https://github.com/realm/SwiftLint.git",
            .upToNextMinor(from: "0.55.0")
        ),
        .package(
            url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git",
            .upToNextMinor(from: "3.1.0")
        ),
    ],
    targets: [
        .target(
            name: "AnalyticsManager",
            dependencies: [
                .product(
                    name: "AppMetricaCore",
                    package: "appmetrica-sdk-ios"
                )
            ],
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .target(
            name: "Banner",
            dependencies: [
                "AnalyticsManager",
                .product(
                    name: "SDWebImageSwiftUI",
                    package: "SDWebImageSwiftUI"
                ),
            ],
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .target(
            name: "Onboarding",
            resources: [.process("Resources/Assets.xcassets")],
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .target(
            name: "ReviewHandler",
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .target(
            name: "Root",
            dependencies: [
                "AnalyticsManager",
                "Onboarding",
                "ReviewHandler",
                "SurebetCalculator",
                .product(
                    name: "AppMetricaCore",
                    package: "appmetrica-sdk-ios"
                )
            ],
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .target(
            name: "SurebetCalculator",
            dependencies: [
                "Banner",
            ],
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .testTarget(
            name: "OnboardingTests",
            dependencies: ["Onboarding"],
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
        .testTarget(
            name: "SurebetCalculatorTests",
            dependencies: ["SurebetCalculator"],
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLint"
                )
            ]
        ),
    ]
)
