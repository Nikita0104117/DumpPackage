// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dump",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AFNetworkingSession",
            targets: ["AFNetworkingSession"]
        ),
        .library(
            name: "TokenManager",
            targets: ["TokenManager", "Store", "AFNetworkingSession"]
        ),
        .library(
            name: "AFNetworkingUI",
            targets: ["AFNetworkingUI", "Style"]
        ),
        .library(
            name: "Store",
            targets: ["Store"]
        ),
        .library(
            name: "Style",
            targets: ["Style"]
        ),
        .library(
            name: "BaseProtocols",
            targets: ["BaseProtocols", "AFNetworkingUI"]
        ),
        .library(
            name: "Extentions",
            targets: ["Extentions"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            from: "5.6.1"
        ),
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            from: "4.2.2"
        ),
        .package(
            url: "https://github.com/auth0/JWTDecode.swift.git",
            from: "2.6.3"
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            from: "5.6.0"
        ),
        .package(
            url: "https://github.com/ninjaprox/NVActivityIndicatorView.git",
            from: "5.1.1"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AFNetworkingSession",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ],
            path: "Sources/AFNetworkingSession"
        ),
        .target(
            name: "TokenManager",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "JWTDecode", package: "JWTDecode.swift"),
                "Store",
                "AFNetworkingSession"
            ],
            path: "Sources/TokenManager"
        ),
        .target(
            name: "AFNetworkingUI",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "NVActivityIndicatorView", package: "NVActivityIndicatorView"),
                "Style"
            ],
            path: "Sources/AFNetworkingUI"
        ),
        .target(
            name: "Store",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "Sources/Store"
        ),
        .target(
            name: "Style",
            dependencies: [ ],
            path: "Sources/Style"
        ),
        .target(
            name: "BaseProtocols",
            dependencies: [
                "AFNetworkingUI"
            ],
            path: "Sources/BaseProtocols"
        ),
        .target(
            name: "Extentions",
            dependencies: [ ],
            path: "Sources/Extentions"
        )
    ]
)
