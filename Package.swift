// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "whisperkit",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "WhisperKit",
            targets: ["WhisperKit"]
        ),
        .executable(
            name: "whisperkit-cli",
            targets: ["WhisperKitCLI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/saamerm/swift-transformers-ios15.git", exact: "0.2.2"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.4.0"),
    ],
    targets: [
        .target(
            name: "WhisperKit",
            dependencies: [
                .product(name: "Transformers", package: "swift-transformers-ios15"),
            ]
        ),
        .executableTarget(
            name: "WhisperKitCLI",
            dependencies: [
                "WhisperKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "WhisperKitTests",
            dependencies: [
                "WhisperKit",
                .product(name: "Transformers", package: "swift-transformers-ios15"),
            ],
            path: ".",
            exclude: [
                "Examples",
                "Sources",
                "Makefile",
                "README.md",
                "LICENSE",
                "CONTRIBUTING.md",
            ],
            resources: [
                .process("Tests/WhisperKitTests/Resources"),
                .copy("Models/whisperkit-coreml"),
            ]
        ),
    ]
)
