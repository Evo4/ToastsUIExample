// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToastsUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ToastsUI",
            targets: ["ToastsUI"]
        ),
    ],
    dependencies: [
      .package(url: "https://github.com/sunghyun-k/swiftui-window-overlay.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ToastsUI",
            dependencies: [
              .product(name: "WindowOverlay", package: "swiftui-window-overlay"),
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
