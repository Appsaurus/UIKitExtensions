// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "UIKitExtensions",
	products: [
		.library(name: "UIKitExtensions", targets: ["UIKitExtensions"])
	],
	dependencies: [],
	targets: [
	.target(name: "UIKitExtensions", dependencies: [], path: "Sources/Shared"),
		.testTarget(name: "UIKitExtensionsTests", dependencies: ["UIKitExtensions"], path: "UIKitExtensionsTests/Shared")
	]
)
