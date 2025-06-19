// swift-tools-version: 5.8
import PackageDescription

let package = Package(
	name: "SIDCore",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v14)
	],
	products: [
		.library(
			name: "SIDCoreDynamic",
			targets: ["SIDCoreDynamicWrapper"]
		),
		.library(
			name: "SIDCoreStatic",
			targets: ["SIDCoreStaticWrapper"]
		)
	],
	dependencies: [
		.package(
			url: "https://github.com/clickstream-developers/Clickstream-iOS",
			from: "1.5.0"
		)
	],
	targets: [
		// Бинарная цель для динамической библиотеки
		.target(
			name: "SIDCoreDynamicWrapper",
			dependencies: [
				.target(name: "SIDCoreDynamicBinary"),
				.product(name: "Clickstream", package: "Clickstream-iOS")
			]
		),
		.binaryTarget(
			name: "SIDCoreDynamicBinary",
			path: "XCFrameworks/SIDCoreDynamic.zip"
		),

		// Обёртка над статической библиотекой, куда «прокидываем» bundle
		.target(
			name: "SIDCoreStaticWrapper",
			dependencies: [
				.target(name: "SIDCoreStaticBinary"),
				.product(name: "Clickstream", package: "Clickstream-iOS")
			],
			exclude: ["SIDSDKResourcesBundle.bundle/Info.plist"],
			resources: [
				.process("SIDSDKResourcesBundle.bundle")
			]
		),
		// Бинарная цель для статической библиотеки
		.binaryTarget(
			name: "SIDCoreStaticBinary",
			path: "./XCFrameworks/SIDCoreStatic.zip"
		)
	]
)
