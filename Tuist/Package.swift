// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        productTypes: [
            "Dependencies": .framework,
            "ComposableArchitecture": .framework
        ]
    )
#endif

let package = Package(
    name: "AdidasPokedex",
    dependencies: [
        // Add your own dependencies here:
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.6.3"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.7.3")
    ]
)
