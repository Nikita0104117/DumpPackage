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
            targets: ["AFNetworkingSessionTarget"]
        ),
        .library(
            name: "AFNetworkingSessionWithTokenManager",
            targets: ["AFNetworkingSessionWithTokenManagerTarget", "StoreTarget", "AFNetworkingSessionTarget"]
        ),
        .library(
            name: "AFNetworkingUI",
            targets: ["AFNetworkingUITarget", "StyleTarget"]
        ),
        .library(
            name: "Store",
            targets: ["StoreTarget"]
        ),
        .library(
            name: "Style",
            targets: ["StyleTarget"]
        ),
//        .library(
//            name: "BaseProtocols",
//            targets: ["BaseProtocolsTarget", "AFNetworkingUITarget"]
//        ),
        .library(
            name: "Extentions",
            targets: ["ExtentionsTarget"]
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
            name: "AFNetworkingSessionTarget",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ],
            path: "Sources/AFNetworkingSession"
        ),
        .target(
            name: "AFNetworkingSessionWithTokenManagerTarget",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "JWTDecode", package: "JWTDecode.swift"),
                "StoreTarget",
                "AFNetworkingSessionTarget"
            ],
            path: "Sources/AFNetworkingSessionWithTokenManager"
        ),
        .target(
            name: "AFNetworkingUITarget",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "NVActivityIndicatorView", package: "NVActivityIndicatorView"),
                "StyleTarget"
            ],
            path: "Sources/AFNetworkingUI"
        ),
        .target(
            name: "StoreTarget",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "Sources/Store"
        ),
        .target(
            name: "StyleTarget",
            dependencies: [ ],
            path: "Sources/Style"
        ),
//        .target(
//            name: "BaseProtocolsTarget",
//            dependencies: [
//                "AFNetworkingUITarget"
//            ],
//            path: "Sources/BaseProtocols"
//        ),
        .target(
            name: "ExtentionsTarget",
            dependencies: [ ],
            path: "Sources/Extentions"
        )
    ]
)
