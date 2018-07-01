// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StockKit",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", "4.0.0" ..< "5.0.0"),
        .package(url: "https://github.com/Nonchalant/SlackKit.git", .branch("linux_compile_error")),
        .package(url: "https://github.com/behrang/YamlSwift.git", .upToNextMinor(from: "3.4.3")),
        .package(url: "https://github.com/kylef/PathKit.git", .upToNextMinor(from: "0.9.1"))
    ],
    targets: [
        .target(
            name: "StockKit",
            dependencies: [
                "Notification",
                "PathKit",
                "RxSwift",
                "Yaml"
            ]
        ),
        .target(
            name: "Notification",
            dependencies: [
                "Finance",
                "SlackKit",
                "Yaml"
            ]
        ),
        .target(
            name: "Finance",
            dependencies: [
                "RxSwift",
                "Yaml"
            ]
        )
    ]
)
